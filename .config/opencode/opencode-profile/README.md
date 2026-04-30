# opencode-profile

Profile-aware config switcher for [opencode](https://opencode.ai). Auto-selects
a profile based on the current working directory and applies it on startup.

A profile bundles two things:

- **`opencode`** — a slice of opencode config (`mcp`, `provider`, `lsp`,
  `agent`, etc.) that is **deep-merged** into the runtime config.
- **`oh_my_openagent`** — a complete [oh-my-openagent](https://www.npmjs.com/package/oh-my-openagent)
  config (agent → model mappings, categories) that is **written to**
  `~/.config/opencode/oh-my-openagent.json` before oh-my-openagent loads.

## Why two slices?

Opencode reads its own config (`mcp`, `provider`, ...) from `opencode.jsonc`.
Plugins can mutate that config via the `config` hook.

`oh-my-openagent`, however, reads its own JSON file (`oh-my-openagent.json`)
from disk **synchronously inside its plugin init**. That file is the only
place agent → model mappings live. To swap them per profile, this plugin
rewrites that file before `oh-my-openagent` loads.

This works because opencode loads plugins in the order listed in
`opencode.jsonc`'s `plugin` array. **`opencode-profile` must be listed first**.

## Install

In `~/.config/opencode/opencode.jsonc`, list `opencode-profile` before
`oh-my-openagent`:

```jsonc
{
  "plugin": [
    "file:/Users/you/path/to/opencode-profile",
    "oh-my-openagent@latest"
  ]
}
```

Then build:

```sh
cd /path/to/opencode-profile
bun install
bun run build
```

## Profile registry

`~/.config/opencode/profiles/_registry.json`:

```json
{
  "rules": [
    { "match": "~/work/callbell",     "profile": "callbell" },
    { "match": "~/work/callbell/**",  "profile": "callbell" },
    { "match": "~/personal/**",       "profile": "personal" }
  ],
  "default": "personal"
}
```

- Rules are checked in array order; first match wins.
- `match` supports `~` (home), exact paths, ancestor-prefix paths, and
  globs (`*`, `?`, `[`, `{`).
- `default` is used when no rule matches.
- The plugin is a no-op if `_registry.json` is absent and `OPENCODE_PROFILE`
  is unset.

## Profile file

`~/.config/opencode/profiles/<name>.json`:

```jsonc
{
  "opencode": {
    "mcp": {
      "callbell_db": { "type": "local", "command": ["psql", "..."] },
      "sentry":      { "enabled": false }
    },
    "provider": {
      "anthropic": { "options": { "timeout": 600000 } }
    }
  },

  "oh_my_openagent": {
    "agents": {
      "sisyphus": { "model": "anthropic/claude-opus-4-7", "variant": "default" },
      "oracle":   { "model": "github-copilot/gpt-5.4", "variant": "high" }
    },
    "categories": {
      "quick": { "model": "anthropic/claude-haiku-4-5" }
    }
  }
}
```

## Merge semantics (for the `opencode` slice)

| Type | Behavior |
| --- | --- |
| Plain object | Recursive deep merge; profile wins on leaf conflicts |
| Array | Concatenated and deduped (JSON-string equality) |
| Scalar / null / type mismatch | Profile replaces |

Note: `oh_my_openagent` is **not merged** with the existing file — the profile
slice fully replaces it. (oh-my-openagent itself merges its own user vs
project configs internally.)

## Override at runtime

```sh
OPENCODE_PROFILE=callbell opencode
```

Skips the registry entirely.

## Logs

Every startup logs the resolved profile via the opencode SDK logger
(`service: "opencode-profile"`). Tail logs with:

```sh
tail -f ~/.local/share/opencode/log/*.log
```

## License

MIT.
