/**
 * opencode-profile
 *
 * Auto-selects a profile based on cwd and applies it to opencode at plugin
 * init time:
 *   - rewrites ~/.config/opencode/oh-my-openagent.json with the profile's
 *     `oh_my_openagent` slice (so oh-my-openagent reads it on next load),
 *   - returns a `config` hook that deep-merges `opencode` slice into the
 *     opencode runtime config.
 *
 * This plugin MUST be listed before `oh-my-openagent` in opencode.jsonc's
 * `plugin` array so the file-write completes before oh-my-openagent's init
 * reads it.
 */

import { existsSync, mkdirSync, readFileSync, renameSync, writeFileSync } from "node:fs";
import { homedir } from "node:os";
import { dirname, join, resolve } from "node:path";

import { parse as parseJsonc } from "jsonc-parser";
import { minimatch } from "minimatch";

import type { Plugin, PluginInput, PluginModule } from "@opencode-ai/plugin";

const SERVICE = "opencode-profile";
const ENV_OVERRIDE = "OPENCODE_PROFILE";

type LogFn = (level: "debug" | "info" | "warn" | "error", message: string, extra?: Record<string, unknown>) => void;

interface RegistryRule {
  match: string;
  profile: string;
}

interface Registry {
  rules?: RegistryRule[];
  default?: string;
}

interface ProfileFile {
  opencode?: Record<string, unknown>;
  oh_my_openagent?: Record<string, unknown>;
}

const HOME = homedir();

function expandTilde(p: string): string {
  if (p === "~") return HOME;
  if (p.startsWith("~/")) return join(HOME, p.slice(2));
  return p;
}

function getOpencodeConfigDir(): string {
  const explicit = process.env.OPENCODE_CONFIG_DIR;
  if (explicit && explicit.length > 0) return resolve(explicit);
  const xdg = process.env.XDG_CONFIG_HOME;
  if (xdg && xdg.length > 0) return join(xdg, "opencode");
  return join(HOME, ".config", "opencode");
}

function readJsoncFile<T>(path: string): T | null {
  if (!existsSync(path)) return null;
  try {
    const raw = readFileSync(path, "utf-8");
    const parsed = parseJsonc(raw);
    if (parsed == null) return null;
    return parsed as T;
  } catch {
    return null;
  }
}

function atomicWriteJson(path: string, value: unknown): void {
  const dir = dirname(path);
  if (!existsSync(dir)) mkdirSync(dir, { recursive: true });
  const tmp = `${path}.tmp`;
  const content = `${JSON.stringify(value, null, 2)}\n`;
  writeFileSync(tmp, content, "utf-8");
  renameSync(tmp, path);
}

function isPlainObject(v: unknown): v is Record<string, unknown> {
  return typeof v === "object" && v !== null && !Array.isArray(v) && Object.getPrototypeOf(v) === Object.prototype;
}

/**
 * Deep merge `override` into `base` (mutates base).
 * Plain objects recurse; arrays concat-and-dedupe (JSON-string equality);
 * everything else (scalars, null, type mismatches) replaces.
 */
function deepMergeInto(base: Record<string, unknown>, override: Record<string, unknown>): void {
  for (const key of Object.keys(override)) {
    const overrideValue = override[key];
    const baseValue = base[key];

    if (isPlainObject(overrideValue) && isPlainObject(baseValue)) {
      deepMergeInto(baseValue, overrideValue);
      continue;
    }

    if (Array.isArray(overrideValue) && Array.isArray(baseValue)) {
      base[key] = mergeArraysDedup(baseValue, overrideValue);
      continue;
    }

    base[key] = overrideValue;
  }
}

function mergeArraysDedup(a: unknown[], b: unknown[]): unknown[] {
  const seen = new Set<string>();
  const out: unknown[] = [];
  for (const item of [...a, ...b]) {
    const key = typeof item === "string" ? item : JSON.stringify(item);
    if (seen.has(key)) continue;
    seen.add(key);
    out.push(item);
  }
  return out;
}

interface ResolvedProfile {
  name: string;
  source: "env" | "registry-rule" | "registry-default";
  matchedRule?: string;
}

function resolveProfileName(directory: string, registry: Registry | null, log: LogFn): ResolvedProfile | null {
  const envValue = process.env[ENV_OVERRIDE];
  if (envValue && envValue.length > 0) {
    log("info", `profile from env ${ENV_OVERRIDE}`, { profile: envValue });
    return { name: envValue, source: "env" };
  }

  if (!registry) return null;

  for (const rule of registry.rules ?? []) {
    if (!rule || typeof rule.match !== "string" || typeof rule.profile !== "string") continue;
    if (matchesPath(directory, expandTilde(rule.match))) {
      return { name: rule.profile, source: "registry-rule", matchedRule: rule.match };
    }
  }

  if (typeof registry.default === "string" && registry.default.length > 0) {
    return { name: registry.default, source: "registry-default" };
  }

  return null;
}

function matchesPath(directory: string, pattern: string): boolean {
  const dir = resolve(directory);

  if (/[*?[{]/.test(pattern)) {
    return minimatch(dir, pattern, { dot: true, nocase: false });
  }

  const pat = resolve(pattern);
  if (dir === pat) return true;
  if (dir.startsWith(pat + "/")) return true;
  return false;
}

const profilePlugin: Plugin = async (input: PluginInput) => {
  const log = createLogger(input);

  const configDir = getOpencodeConfigDir();
  const profilesDir = join(configDir, "profiles");
  const registryPath = join(profilesDir, "_registry.json");
  const ohMyAgentPath = join(configDir, "oh-my-openagent.json");

  const registry = readJsoncFile<Registry>(registryPath);
  if (!registry && !process.env[ENV_OVERRIDE]) {
    log("info", "no registry and no env override - profile inactive", { registryPath });
    return {};
  }

  const resolved = resolveProfileName(input.directory, registry, log);
  if (!resolved) {
    log("warn", "no profile matched and no default set - profile inactive", {
      directory: input.directory,
      registryPath,
    });
    return {};
  }

  const profilePath = join(profilesDir, `${resolved.name}.json`);
  const profile = readJsoncFile<ProfileFile>(profilePath);
  if (!profile) {
    log("error", "profile file not found or unreadable", {
      profile: resolved.name,
      profilePath,
      source: resolved.source,
    });
    return {};
  }

  if (profile.oh_my_openagent && Object.keys(profile.oh_my_openagent).length > 0) {
    try {
      atomicWriteJson(ohMyAgentPath, profile.oh_my_openagent);
      log("info", "wrote oh-my-openagent.json from profile", {
        profile: resolved.name,
        path: ohMyAgentPath,
      });
    } catch (err) {
      log("error", "failed to write oh-my-openagent.json", {
        profile: resolved.name,
        path: ohMyAgentPath,
        error: err instanceof Error ? err.message : String(err),
      });
    }
  } else {
    log("info", "profile has no oh_my_openagent slice - leaving existing file untouched", {
      profile: resolved.name,
    });
  }

  log("info", "profile resolved", {
    profile: resolved.name,
    source: resolved.source,
    matchedRule: resolved.matchedRule,
    directory: input.directory,
  });

  return {
    config: async (cfg) => {
      if (!profile.opencode || Object.keys(profile.opencode).length === 0) return;
      deepMergeInto(cfg as unknown as Record<string, unknown>, profile.opencode);
      log("info", "merged profile.opencode into runtime config", {
        profile: resolved.name,
        keys: Object.keys(profile.opencode),
      });
    },
  };
};

function createLogger(input: PluginInput): LogFn {
  return (level, message, extra) => {
    try {
      void input.client.app.log({
        body: {
          service: SERVICE,
          level,
          message,
          extra: extra ?? {},
        },
      });
    } catch {
      const prefix = `[${SERVICE}] ${level.toUpperCase()}`;
      if (extra) console.error(prefix, message, extra);
      else console.error(prefix, message);
    }
  };
}

const pluginModule: PluginModule = {
  id: SERVICE,
  server: profilePlugin,
};

export default pluginModule;
