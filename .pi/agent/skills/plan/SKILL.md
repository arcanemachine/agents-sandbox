---
name: plan
description: When the user types /plan, enter plan mode. In plan mode, do NOT make any changes to files. Only analyze, explain the approach, and wait for user confirmation before proceeding.
---

# Plan Mode

When the user types `/plan` followed by a request:

1. **DO NOT** use `write`, `edit`, or any tool that modifies files
2. **ONLY** use `read` and `bash` to analyze the codebase
3. Explain what you would do
4. Wait for user confirmation before making changes

## Behavior

- Acknowledge you're in plan mode
- Analyze relevant files
- Present a clear plan of action
- Ask "Should I proceed?" or wait for explicit go-ahead
- Exit plan mode when user confirms or cancels
