# Global Instructions

This is an OpenCode configuration repository containing AI agents, commands, context files, and tools for the OpenAgents framework.

## Project Overview

**Type:** OpenCode Agent System Configuration
**Runtime:** Node.js/Bun with TypeScript
**Package Manager:** npm/pnpm/bun
**Primary Language:** TypeScript (for tools), Markdown (for agents/commands/context)

## Build/Lint/Test Commands

This repository primarily contains markdown configuration files. For TypeScript tools:

```bash
# Install dependencies
bun install

# Type checking (if tsconfig exists)
npx tsc --noEmit

# Run single test (if testing configured)
npx vitest run path/to/test.ts
npx jest path/to/test.ts

# Lint (if eslint configured)
npx eslint .
npx eslint path/to/file.ts --fix
```

For projects using this configuration, common commands from `/command/test.md`:

```bash
pnpm type:check    # TypeScript type checking
pnpm lint          # ESLint
pnpm test          # Run test suite
pnpm build         # Build project
```

## Code Style Guidelines

### TypeScript/JavaScript

**File Naming:** `lowercase-with-dashes.ts` (e.g., `env-loader.ts`)

**Imports:**

- Sort alphabetically
- Group by type: external libraries, then local files
- Remove unused imports
- Use absolute imports when configured

**Formatting:**

- Use Prettier defaults
- 2-space indentation
- Single quotes preferred
- Trailing commas in multiline

**Types:**

- Explicit interface definitions with JSDoc comments
- Use `interface` for object shapes, `type` for unions/aliases
- Avoid `any` - use `unknown` when type is uncertain
- Document function parameters and return types

```typescript
/**
 * Configuration for environment variable loading
 */
export interface EnvLoaderConfig {
  /** Custom paths to search for .env files */
  searchPaths?: string[];
  /** Whether to log when environment variables are loaded */
  verbose?: boolean;
}
```

**Functions:**

- Pure functions preferred (same input = same output, no side effects)
- Keep functions < 50 lines
- Use early returns to reduce nesting
- Async/await over raw promises

**Error Handling:**

- Return result objects: `{ success: true, data } | { success: false, error }`
- Never swallow errors silently
- Log errors with context
- Validate at boundaries

```typescript
try {
  const result = await operation();
  return { success: true, data: result };
} catch (error) {
  return { success: false, error: error.message };
}
```

**Naming Conventions:**

- Functions: `verbPhrases` (getUser, validateEmail, loadEnvVariables)
- Predicates: `isValid`, `hasPermission`, `canAccess`
- Variables: descriptive names, `const` by default
- Constants: `UPPER_SNAKE_CASE`

### Markdown (Agents/Commands/Context)

**Agent Structure:**

```markdown
---
id: agent-name
name: Agent Display Name
description: "What this agent does"
mode: primary|subagent
tools: [read, edit, bash, etc.]
---

# Agent Name

[Direct instructions for behavior]

## Workflow

1. Step one
2. Step two

## Rules

- **ALWAYS** [critical requirement]
- **NEVER** [forbidden action]
```

**Command Structure:**

```markdown
---
description: What this command does
---

# Command Name

You are [doing specific task].

## Instructions

1. Step one
2. Step two
```

**Context Files:**

- Keep focused: 50-150 lines each
- Include quick reference section at top
- Use headers and bullet points for scannability
- Maximum 4 context files per command (250-450 lines total)

## Anti-Patterns to Avoid

- Mutation and side effects in pure functions
- Deep nesting (> 3 levels) - use early returns
- God modules (> 200 lines)
- Global state - pass dependencies explicitly
- Large functions (> 50 lines)
- Hardcoded credentials or secrets
- ESLint disable comments - fix the actual issue instead

## Session Learnings

When you discover important information during a session that could be useful in future conversations, save it to `~/.config/opencode/learnings/` as a markdown file.

### What to Save

- Workarounds for errors or issues (especially production-related)
- Project-specific configurations or credentials patterns
- Database commands and fixes
- Deployment procedures
- Environment-specific quirks
- Any "gotcha" moments that took time to figure out

### How to Save

1. Create a descriptive filename: `~/.config/opencode/learnings/<topic>.md`
2. Use clear markdown with headings
3. Include the problem, solution, and any relevant context
4. If a file for that topic exists, append to it rather than creating duplicates
5. **IMPORTANT: Always redact sensitive information** - Never include API keys, passwords, tokens, secrets, or credentials. Use placeholders like `<API_KEY>`, `<PASSWORD>`, or `your_secret_here` instead

### When to Save

- At the end of a debugging session where something non-obvious was discovered
- When the user explicitly asks to save a learning
- When you find a solution that isn't well-documented elsewhere
- **PROACTIVE:** Always save learnings automatically when discovering non-obvious solutions

### Session Requirement

**Save at least one interesting piece of information per session** - either during the session as discoveries happen, or at the end.

## Available Commands

| Command          | Description                                                |
| ---------------- | ---------------------------------------------------------- |
| `/commit`        | Create well-formatted git commits with conventional format |
| `/test`          | Run the complete testing pipeline (type-check, lint, test) |
| `/review`        | Run CodeRabbit AI code review on changes                   |
| `/optimize`      | Analyze code for performance, security, and issues         |
| `/clean`         | Clean codebase via Prettier, ESLint, and TypeScript        |
| `/context`       | Context management operations                              |
| `/validate-repo` | Validate repository consistency                            |

## Directory Structure

```
.config/opencode/
├── agent/           # AI agents (core/, development/, subagents/)
├── command/         # Slash commands (/commit, /test, /review, etc.)
├── context/         # Knowledge base (core/, project/, project-intelligence/)
├── learnings/       # Session learnings (auto-saved discoveries)
├── skill/           # Skill definitions
├── tool/            # TypeScript tools (env loader, etc.)
├── opencode.json    # Main configuration
└── AGENTS.md        # This file
```

## Security Guidelines

- Never commit `.env` files or credentials
- Use environment variables for all secrets
- Agents have restricted permissions by default
- Sensitive operations require explicit approval
- Validate and sanitize all user input
