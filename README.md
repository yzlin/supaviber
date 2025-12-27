# SupaViber

> Your personal vibe coding toolkit - custom skills, agents, and commands for an optimized development environment

SupaViber is a [Claude Code](https://claude.com/claude-code) plugin that helps you manage and share your custom development workflows, automation, and AI-powered tools. Build your ideal coding environment with reusable components.

## What is SupaViber?

SupaViber provides a structured way to organize and share:

- **Skills** - AI workflows that Claude automatically uses based on context
- **Agents** - Specialized subagents for specific tasks
- **Commands** - User-invoked slash commands for common operations
- **Hooks** - Event-driven automation that runs automatically

Whether you're setting up a new machine or sharing your workflows with a team, SupaViber makes it easy to package and deploy your development environment.

## Installation

### Install from GitHub

```bash
claude plugin install https://github.com/yzlin/supaviber
```

### Install Locally

Clone this repository and load it as a local plugin:

```bash
git clone https://github.com/yzlin/supaviber.git
claude --plugin-dir ./supaviber
```

### Verify Installation

Check that the plugin is loaded:

```bash
claude plugin list
```

You should see `supaviber` in the list of active plugins.

## Quick Start

### 1. Add Your First Skill

Create a new skill directory with a `SKILL.md` file:

```bash
mkdir -p skills/my-workflow
```

Create `skills/my-workflow/SKILL.md`:

```markdown
---
name: my-workflow
description: Describe when Claude should use this skill
---

Your skill instructions here...
```

### 2. Create a Slash Command

Add a command file to `commands/`:

```bash
echo "---
description: Example command
---

Do something useful!" > commands/example.md
```

Use it with: `/supaviber:example`

### 3. Define a Custom Agent

Create `agents/my-agent.md`:

```markdown
---
description: Specialized agent for X
capabilities: ["capability1", "capability2"]
---

# My Agent

This agent specializes in...
```

## Components

### Skills (`skills/`)

Agent Skills that Claude automatically invokes based on task context. Each skill is a subdirectory containing a `SKILL.md` file.

**Structure:**
```
skills/
└── skill-name/
    ├── SKILL.md       # Required: skill definition
    └── reference.md   # Optional: additional context
```

See [skills/README.md](skills/README.md) for detailed documentation.

### Agents (`agents/`)

Custom subagents with specialized capabilities. Each agent is defined in a markdown file.

**Structure:**
```
agents/
└── agent-name.md
```

See [agents/README.md](agents/README.md) for detailed documentation.

### Commands (`commands/`)

User-invoked slash commands. Filename becomes the command name (prefixed with `supaviber:`).

**Structure:**
```
commands/
└── command-name.md    # Creates /supaviber:command-name
```

See [commands/README.md](commands/README.md) for detailed documentation.

### Hooks (`hooks/`)

Event-driven automation that triggers on Claude Code events like file changes, session start, etc.

**Structure:**
```
hooks/
└── hooks.json         # Hook configuration
```

See [hooks/README.md](hooks/README.md) for detailed documentation.

## Development

### Adding Components

1. **Skills**: Create a directory in `skills/` with a `SKILL.md` file
2. **Agents**: Add a `.md` file to `agents/`
3. **Commands**: Add a `.md` file to `commands/`
4. **Hooks**: Edit `hooks/hooks.json` or create individual hook files

### Testing Locally

Load the plugin in development mode:

```bash
cd supaviber
claude --plugin-dir .
```

### Project Structure

```
supaviber/
├── .claude-plugin/
│   └── plugin.json          # Plugin manifest
├── skills/                   # Agent Skills
├── agents/                   # Custom subagents
├── commands/                 # Slash commands
├── hooks/                    # Event automation
├── scripts/                  # Utility scripts
├── README.md                 # This file
├── CHANGELOG.md              # Version history
├── LICENSE                   # MIT license
└── .gitignore               # Git ignore rules
```

## Contributing

Contributions are welcome! Here's how you can help:

1. **Fork** this repository
2. **Create** a feature branch: `git checkout -b feat/my-skill`
3. **Add** your skill, agent, or command
4. **Test** it works: `claude --plugin-dir .`
5. **Commit** your changes: `git commit -m "feat: add my awesome skill"`
6. **Push** to your fork: `git push origin feat/my-skill`
7. **Submit** a pull request

### Commit Convention

We use [Conventional Commits](https://www.conventionalcommits.org/):

- `feat:` - New skills, agents, or commands
- `fix:` - Bug fixes in existing components
- `docs:` - Documentation updates
- `chore:` - Maintenance tasks

## Examples

### Example: Code Review Skill

```markdown
# skills/code-review/SKILL.md
---
name: code-review
description: Review code for best practices and potential issues
---

When reviewing code, check for:
1. Code organization and structure
2. Error handling
3. Security concerns
4. Test coverage
5. Performance optimizations

Provide specific feedback with line numbers.
```

### Example: Deploy Command

```markdown
# commands/deploy.md
---
description: Deploy the current project
---

Check the deployment status and run the deployment process.
Provide clear feedback on success or failure.
```

## License

MIT License - see [LICENSE](LICENSE) file for details.

## Links

- [Claude Code Documentation](https://code.claude.com/docs)
- [Plugin Development Guide](https://code.claude.com/docs/en/plugins.md)
- [Report Issues](https://github.com/yzlin/supaviber/issues)

---

**Built with vibe** ✨
