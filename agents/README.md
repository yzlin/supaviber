# Agents Directory

This directory contains custom subagent definitions for specialized tasks.

## What are Custom Agents?

Custom agents are specialized AI assistants that Claude can invoke for specific tasks. Each agent has defined capabilities and expertise areas.

## Creating an Agent

### 1. Create an Agent File

Each agent is a single markdown file in this directory:

```bash
touch agents/my-agent.md
```

### 2. Define the Agent

Use YAML frontmatter to specify the agent's properties:

```markdown
---
description: Brief description of what this agent does
capabilities: ["capability1", "capability2", "capability3"]
---

# Agent Name

Detailed description of the agent's purpose and expertise.

## Capabilities
- List the agent's specific skills
- What tasks it's optimized for
- When to invoke this agent

## Usage
Explain how and when to use this agent.

## Examples
Show example scenarios where this agent excels.
```

## Agent Format

### Frontmatter

```yaml
---
description: Short description shown in agent list
capabilities: ["list", "of", "capabilities"]
---
```

### Body

- **Purpose**: What the agent specializes in
- **Capabilities**: Specific tasks it can handle
- **When to Use**: Scenarios for invocation
- **Examples**: Sample use cases

## Example Agent

```markdown
---
description: Reviews code for best practices, security, and performance
capabilities: ["code review", "security audit", "performance analysis", "quality assessment"]
---

# Code Review Agent

A specialized agent for comprehensive code reviews, focusing on quality, security, and performance.

## Capabilities

- **Best Practices**: Analyze code structure, naming, and organization
- **Security Audit**: Identify vulnerabilities and security concerns
- **Performance Review**: Spot inefficiencies and optimization opportunities
- **Test Coverage**: Assess testing completeness and quality

## When to Use

Invoke this agent when:
- Reviewing pull requests
- Auditing codebase quality
- Performing security assessments
- Analyzing performance bottlenecks

## Review Process

1. Analyze code structure and organization
2. Check for security vulnerabilities
3. Identify performance issues
4. Verify test coverage
5. Provide actionable recommendations

## Output Format

Reviews include:
- File paths and line numbers
- Severity ratings (Critical/High/Medium/Low)
- Specific issues found
- Recommended fixes
- Code examples
```

## Another Example: Test Generator

```markdown
---
description: Generates comprehensive test suites for code
capabilities: ["test generation", "test planning", "edge case identification"]
---

# Test Generator Agent

Specializes in creating thorough test suites with unit tests, integration tests, and edge cases.

## Capabilities

- Generate unit tests for functions and classes
- Create integration tests for workflows
- Identify edge cases and boundary conditions
- Suggest test fixtures and mocks

## When to Use

- Writing tests for new features
- Improving test coverage
- Refactoring with test safety
- Setting up test infrastructure

## Test Philosophy

- Aim for high coverage with meaningful tests
- Focus on behavior, not implementation
- Include happy path, edge cases, and errors
- Make tests readable and maintainable
```

## Invoking Agents

Agents appear in the `/agents` interface and can be invoked by:

1. **User**: Explicitly calling the agent
2. **Claude**: Automatically when recognizing a matching task
3. **Other agents**: As part of a workflow

## Best Practices

1. **Focused Expertise**: Each agent should have a clear, specific purpose
2. **Clear Capabilities**: List exactly what the agent can do
3. **Usage Guidelines**: Explain when to invoke the agent
4. **Actionable Output**: Define what results the agent provides
5. **Examples**: Show the agent in action

## Testing Agents

Load the plugin and check the agent is available:

```bash
claude --plugin-dir /path/to/supaviber
```

Then check `/agents` to see your custom agents listed.

## Agent vs Skill vs Command

- **Agents**: Specialized subagents with specific expertise
- **Skills**: Automatic workflows Claude invokes based on context
- **Commands**: User-invoked slash commands

Choose agents when you want a specialized assistant for a particular domain.

## More Resources

- [Claude Code Documentation](https://code.claude.com/docs)
- [Main Plugin README](../README.md)
- [Custom Agents Guide](https://code.claude.com/docs/en/custom-agents.md)
