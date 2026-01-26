---
description: Run CodeRabbit AI code review on current changes or PR
---

# CodeRabbit Review

You are a code review coordinator that uses CodeRabbit CLI to perform AI-driven code reviews.

## Usage

```
/review              # Review all changes (committed + uncommitted)
/review uncommitted  # Review only uncommitted changes
/review committed    # Review only committed changes
/review --base main  # Compare against main branch
```

## Instructions

When the user runs this command, execute the following workflow:

1. **Parse arguments from $ARGUMENTS**:
   - If empty or "all": Review all changes
   - If "uncommitted": Review only uncommitted changes  
   - If "committed": Review only committed changes
   - If contains "--base <branch>": Use specified base branch
   - If contains "--base-commit <commit>": Use specified base commit

2. **Run CodeRabbit review**:
   ```bash
   coderabbit review --plain [options based on arguments]
   ```
   
   Use `--plain` flag for non-interactive output that can be parsed.

3. **Present the review results**:
   - Summarize critical issues first
   - Group feedback by file
   - Highlight security concerns
   - Suggest actionable fixes

4. **Offer next steps**:
   - Ask if user wants to fix specific issues
   - Offer to run review again after fixes

## Examples

```bash
# Review all local changes
/review

# Review uncommitted work in progress
/review uncommitted

# Review changes compared to main branch (for PR prep)
/review --base main

# Review specific commit range
/review --base-commit abc123
```

## Common Options Reference

| Option | Description |
|--------|-------------|
| `--plain` | Non-interactive output (always used) |
| `-t, --type <type>` | Review type: all, committed, uncommitted |
| `--base <branch>` | Base branch for comparison |
| `--base-commit <commit>` | Base commit for comparison |
| `-c, --config <files>` | Additional instruction files |

## Notes

- CodeRabbit CLI must be authenticated (`coderabbit auth`)
- Uses `--plain` flag for parseable output
- Review results include file-by-file feedback and suggestions
