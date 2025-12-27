# Skills Directory

This directory contains Agent Skills - workflows that Claude automatically invokes based on task context.

## What are Agent Skills?

Agent Skills are AI-powered workflows that Claude uses automatically when relevant to the current task. Unlike slash commands (which are user-invoked), skills are **model-invoked** - Claude decides when to use them.

## Creating a Skill

### 1. Create a Skill Directory

Each skill lives in its own subdirectory:

```bash
mkdir -p skills/my-skill-name
```

### 2. Create SKILL.md

The `SKILL.md` file defines your skill with YAML frontmatter:

```markdown
---
name: my-skill-name
description: Brief description of when to use this skill. Claude uses this to decide when to invoke it.
---

# My Skill Name

Detailed instructions for what Claude should do when this skill is invoked.

## When to Use
Describe the scenarios where this skill applies.

## Process
Step-by-step instructions for Claude to follow.

## Examples
Show examples of the skill in action.
```

### 3. Add Reference Materials (Optional)

You can include additional context files:

```
skills/my-skill-name/
├── SKILL.md          # Required: skill definition
├── reference.md      # Optional: additional context
└── examples.md       # Optional: usage examples
```

## Skill Format

### Frontmatter (Required)

```yaml
---
name: skill-identifier
description: When Claude should use this skill (critical for model decision-making)
---
```

**Important**: The `description` field is how Claude decides when to invoke your skill. Make it clear and specific about the triggering context.

### Body

The markdown body contains:
- **Instructions**: What Claude should do
- **Process**: Step-by-step workflow
- **Guidelines**: Best practices or constraints
- **Examples**: Sample usage (optional)

## Example Skill

```markdown
---
name: code-review
description: Review code for best practices, security issues, and potential bugs. Use when reviewing PRs, analyzing code quality, or auditing codebases.
---

# Code Review Skill

Perform a comprehensive code review following industry best practices.

## Review Checklist

1. **Code Organization**
   - Clear structure and modularity
   - Appropriate separation of concerns
   - Consistent naming conventions

2. **Error Handling**
   - Proper try-catch blocks
   - Meaningful error messages
   - Graceful degradation

3. **Security**
   - Input validation
   - No hardcoded secrets
   - SQL injection prevention
   - XSS protection

4. **Performance**
   - Efficient algorithms
   - No unnecessary computations
   - Appropriate caching

5. **Testing**
   - Adequate test coverage
   - Edge cases handled
   - Integration tests present

## Output Format

Provide feedback with:
- File path and line numbers
- Issue severity (Critical/High/Medium/Low)
- Specific recommendation
- Example fix (if applicable)
```

## Best Practices

1. **Clear Descriptions**: Make the `description` field specific so Claude knows when to invoke
2. **Focused Skills**: One skill = one workflow (avoid combining unrelated tasks)
3. **Actionable Instructions**: Provide clear, step-by-step guidance
4. **Include Examples**: Show what good output looks like
5. **Version Control**: Track changes to skills in git
6. **Test Thoroughly**: Verify skills work as expected before committing

## Testing Your Skills

Load the plugin locally and trigger the skill:

```bash
claude --plugin-dir /path/to/supaviber
```

Claude will automatically use your skills when relevant tasks come up.

## Skill vs Command vs Agent

- **Skills**: Model-invoked workflows that trigger automatically
- **Commands**: User-invoked with `/supaviber:command-name`
- **Agents**: Specialized subagents with specific capabilities

Choose skills when you want Claude to automatically apply a workflow based on context.

## More Resources

- [Claude Code Skills Documentation](https://code.claude.com/docs/en/skills.md)
- [Main Plugin README](../README.md)
- [Example Skills](https://github.com/anthropics/claude-code/tree/main/examples/skills)
