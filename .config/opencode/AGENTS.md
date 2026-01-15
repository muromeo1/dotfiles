# Global Instructions

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
- **PROACTIVE:** Always save learnings automatically when discovering non-obvious solutions — don't wait for the user to ask
