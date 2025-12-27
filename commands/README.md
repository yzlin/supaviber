# Commands Directory

This directory contains slash commands - user-invoked prompts that you trigger manually.

## What are Slash Commands?

Slash commands are predefined prompts that you can invoke with `/supaviber:command-name`. They're useful for:

- Common workflows you run frequently
- Setup and configuration tasks
- Quick access to specialized operations
- Templated interactions

## Creating a Command

### 1. Create a Command File

Each markdown file in this directory becomes a command:

```bash
touch commands/my-command.md
```

The filename becomes the command name:
- `setup.md` → `/supaviber:setup`
- `deploy.md` → `/supaviber:deploy`
- `review-pr.md` → `/supaviber:review-pr`

### 2. Define the Command

Use YAML frontmatter and markdown content:

```markdown
---
description: Brief description shown in command list
---

# Command Name

Instructions for what Claude should do when this command is invoked.

Be specific and actionable!
```

## Command Format

### Frontmatter

```yaml
---
description: Short description of what this command does
---
```

### Body

The markdown body contains the prompt that Claude receives when you run the command.

## Example Commands

### Simple Command (No Arguments)

```markdown
---
description: Show the current project status
---

# Project Status

Display the current project status:

1. Show git status (branch, uncommitted changes)
2. List recent commits (last 5)
3. Check for dependency updates
4. Run tests and show results
5. Display build status

Provide a clear summary of the project health.
```

**Usage**: `/supaviber:status`

### Command with Arguments

Commands can accept arguments using placeholders:

```markdown
---
description: Greet a user by name
---

# Greet Command

Greet the user named "$ARGUMENTS" with a friendly, personalized message.
Ask how you can help them with their coding tasks today.
```

**Usage**: `/supaviber:greet Alice`

**Argument Placeholders:**
- `$ARGUMENTS` - All text after the command
- `$1`, `$2`, `$3`, etc. - Individual positional arguments

### Advanced Example: Deploy Command

```markdown
---
description: Deploy the current project to production
---

# Deploy to Production

Perform a production deployment with safety checks:

## Pre-deployment Checks
1. Verify we're on the main branch
2. Ensure all tests pass
3. Check that there are no uncommitted changes
4. Confirm the build succeeds

## Deployment Process
1. Tag the release with the current version
2. Run the deployment script
3. Monitor the deployment for errors
4. Verify the deployment succeeded

## Post-deployment
1. Smoke test the production environment
2. Monitor logs for issues
3. Update the deployment documentation

**IMPORTANT**: Ask for confirmation before proceeding with deployment.
Abort if any pre-deployment checks fail.
```

### Example: Code Review Command

```markdown
---
description: Review a pull request
---

# Review Pull Request

Review the pull request number "$1" (or current branch if no PR number provided):

1. Fetch the PR details using `gh pr view $1`
2. Review the code changes for:
   - Code quality and best practices
   - Security vulnerabilities
   - Performance concerns
   - Test coverage
3. Check that tests pass
4. Provide structured feedback

Format feedback as:
- **Approvals**: What's done well
- **Required Changes**: Critical issues
- **Suggestions**: Nice-to-have improvements
```

**Usage**: `/supaviber:review-pr 123`

## Command Best Practices

1. **Clear Description**: Make it obvious what the command does
2. **Specific Instructions**: Provide detailed, actionable steps
3. **Handle Arguments**: Use `$ARGUMENTS` or `$1, $2` for flexibility
4. **Safety Checks**: Include validation and confirmation steps
5. **Error Handling**: Specify what to do if things fail
6. **Output Format**: Define how results should be presented

## Testing Commands

Load the plugin and try your command:

```bash
claude --plugin-dir /path/to/supaviber
```

Then run:
```bash
/supaviber:your-command-name
```

## Command vs Skill vs Agent

- **Commands**: User-invoked with `/supaviber:name` (you control when)
- **Skills**: Model-invoked automatically (Claude decides when)
- **Agents**: Specialized subagents for specific domains

Choose commands when you want explicit control over when a workflow runs.

## Common Use Cases

- **Setup**: `/supaviber:setup` - Initialize development environment
- **Deploy**: `/supaviber:deploy` - Deploy to production
- **Test**: `/supaviber:test` - Run test suite
- **Review**: `/supaviber:review-pr` - Review pull requests
- **Docs**: `/supaviber:generate-docs` - Generate documentation
- **Clean**: `/supaviber:clean` - Clean build artifacts

## More Resources

- [Slash Commands Documentation](https://code.claude.com/docs/en/slash-commands.md)
- [Main Plugin README](../README.md)
- [Command Examples](https://code.claude.com/docs/en/slash-commands.md#examples)
