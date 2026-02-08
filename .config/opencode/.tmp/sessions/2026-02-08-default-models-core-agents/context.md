# Task Context: Default models for core agents

Session ID: 2026-02-08-default-models-core-agents
Created: 2026-02-08T00:00:00Z
Status: in_progress

## Current Request
Identify the default models to use for the two core agents.

## Context Files (Standards to Follow)
- /Users/muriloromeo/.config/opencode/context/openagents-repo/core-concepts/agents.md
- /Users/muriloromeo/.config/opencode/context/openagents-repo/core-concepts/agent-metadata.md
- /Users/muriloromeo/.config/opencode/context/openagents-repo/plugins/context/capabilities/agents.md
- /Users/muriloromeo/.config/opencode/context/openagents-repo/guides/adding-agent-basics.md
- /Users/muriloromeo/.config/opencode/context/openagents-repo/guides/testing-agent.md
- /Users/muriloromeo/.config/opencode/context/core/standards/code-quality.md

## Reference Files (Source Material to Look At)
- .opencode/agent/core/*.md (actual core agent definitions)
- .opencode/config/agent-metadata.json (centralized metadata including model overrides if present)
- registry.json (resolved entries used at runtime)

## External Docs Fetched
- None (not needed)

## Components
- Core agent definitions
- Agent metadata and registry

## Constraints
- Follow OpenCode agent metadata rules (model overrides allowed via frontmatter `model`)
- Use repository defaults if defined; otherwise fall back to base agent + variant behavior per agents.md

## Exit Criteria
- [ ] Identify the two core agents
- [ ] State the default model for each, citing source (frontmatter, metadata, or test config)
