# Hooks Directory

This directory contains hook configurations for event-driven automation.

## What are Hooks?

Hooks are event-driven automations that run automatically when specific Claude Code events occur. They let you:

- Run scripts after file changes
- Validate code before commits
- Set up environment on session start
- Clean up resources on session end
- Trigger custom workflows based on tool usage

## Creating Hooks

### 1. Create hooks.json

Create a `hooks.json` file in this directory:

```json
{
  "hooks": {
    "SessionStart": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "${CLAUDE_PLUGIN_ROOT}/scripts/setup.sh"
          }
        ]
      }
    ]
  }
}
```

### 2. Create Hook Scripts

Place your scripts in the `../scripts/` directory:

```bash
touch ../scripts/setup.sh
chmod +x ../scripts/setup.sh
```

## Hook Configuration Format

```json
{
  "hooks": {
    "EventName": [
      {
        "matcher": "optional-pattern",
        "hooks": [
          {
            "type": "command|prompt|agent",
            "command": "script-to-run",
            "args": ["optional", "arguments"]
          }
        ]
      }
    ]
  }
}
```

## Available Hook Events

| Event                  | When it Triggers                          |
|------------------------|-------------------------------------------|
| `SessionStart`         | At the beginning of a Claude session      |
| `SessionEnd`           | At the end of a Claude session            |
| `UserPromptSubmit`     | When user submits a prompt                |
| `PreToolUse`           | Before Claude uses any tool               |
| `PostToolUse`          | After Claude successfully uses a tool     |
| `PostToolUseFailure`   | After a tool execution fails              |
| `PermissionRequest`    | When a permission dialog is shown         |
| `Notification`         | When Claude Code sends notifications      |
| `Stop`                 | When Claude attempts to stop              |
| `SubagentStart`        | When a subagent starts                    |
| `SubagentStop`         | When a subagent stops                     |
| `PreCompact`           | Before conversation history is compacted  |

## Hook Types

### 1. Command Hooks

Run shell commands or scripts:

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Write|Edit",
        "hooks": [
          {
            "type": "command",
            "command": "${CLAUDE_PLUGIN_ROOT}/scripts/format-code.sh",
            "args": ["${TOOL_ARGS}"]
          }
        ]
      }
    ]
  }
}
```

### 2. Prompt Hooks

Evaluate a prompt with the LLM:

```json
{
  "hooks": {
    "UserPromptSubmit": [
      {
        "hooks": [
          {
            "type": "prompt",
            "command": "Analyze the user's request: $ARGUMENTS. Is it clear and specific? If not, suggest improvements."
          }
        ]
      }
    ]
  }
}
```

### 3. Agent Hooks

Run agentic verifiers for complex tasks:

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Write|Edit",
        "hooks": [
          {
            "type": "agent",
            "command": "Review the code changes and ensure they follow best practices."
          }
        ]
      }
    ]
  }
}
```

## Example Hook Configurations

### Auto-format Code After Writes

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Write|Edit",
        "hooks": [
          {
            "type": "command",
            "command": "${CLAUDE_PLUGIN_ROOT}/scripts/format-code.sh"
          }
        ]
      }
    ]
  }
}
```

### Session Setup

```json
{
  "hooks": {
    "SessionStart": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "echo 'Welcome to SupaViber! 🎵'",
            "description": "Welcome message"
          },
          {
            "type": "command",
            "command": "${CLAUDE_PLUGIN_ROOT}/scripts/check-deps.sh",
            "description": "Check dependencies"
          }
        ]
      }
    ]
  }
}
```

### Pre-commit Validation

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash.*git commit",
        "hooks": [
          {
            "type": "command",
            "command": "${CLAUDE_PLUGIN_ROOT}/scripts/pre-commit.sh"
          }
        ]
      }
    ]
  }
}
```

## Environment Variables

Hooks have access to special variables:

- `${CLAUDE_PLUGIN_ROOT}` - Path to plugin directory
- `${TOOL_NAME}` - Name of the tool that triggered the hook
- `${TOOL_ARGS}` - Arguments passed to the tool
- `$ARGUMENTS` - Event-specific arguments

## Matchers

Use regex patterns to match specific tool invocations:

```json
{
  "matcher": "Write|Edit",  // Matches Write OR Edit tools
  "matcher": "Bash.*npm",   // Matches Bash commands containing npm
  "matcher": ".*\\.ts$"     // Matches TypeScript files
}
```

## Best Practices

1. **Keep Scripts Fast**: Hooks run synchronously and can slow down workflows
2. **Use Matchers**: Only run hooks when relevant (don't run on every event)
3. **Handle Errors**: Make scripts robust with proper error handling
4. **Test Thoroughly**: Hooks can break workflows if misconfigured
5. **Document Behavior**: Comment why hooks exist and what they do
6. **Use Absolute Paths**: Always use `${CLAUDE_PLUGIN_ROOT}` for plugin paths

## Example Scripts

### format-code.sh
```bash
#!/bin/bash
# Auto-format code files after writes

if [[ "$1" =~ \.(js|ts|jsx|tsx)$ ]]; then
  npx prettier --write "$1"
fi
```

### check-deps.sh
```bash
#!/bin/bash
# Check if dependencies are up to date

if [ -f "package.json" ]; then
  echo "Checking for dependency updates..."
  npm outdated
fi
```

## Testing Hooks

Load your plugin and trigger the events:

```bash
claude --plugin-dir /path/to/supaviber
```

Monitor the output to see when hooks fire.

## Debugging Hooks

Use `claude --debug` to see hook execution details:

```bash
claude --debug --plugin-dir /path/to/supaviber
```

## More Resources

- [Hooks Guide](https://code.claude.com/docs/en/hooks-guide.md)
- [Hook Events Reference](https://code.claude.com/docs/en/hooks-reference.md)
- [Main Plugin README](../README.md)
