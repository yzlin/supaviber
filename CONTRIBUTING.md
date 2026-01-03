# Contributing to SupaViber

Thank you for contributing to SupaViber! This guide will help you create skills that work seamlessly with both Claude Code and OpenAI Codex.

## Agent Skills Specification

All SupaViber skills follow the [Agent Skills open standard](https://agentskills.io). This ensures compatibility across platforms and makes your skills reusable.

## Creating a New Skill

### 1. Choose a Name

Skill names must:
- Be 1-64 characters
- Use only lowercase letters, numbers, and hyphens
- Not start/end with hyphens
- Not contain consecutive hyphens
- Match the directory name exactly

**Good**: `git-safety`, `code-review`, `deploy-prod`
**Bad**: `Git-Safety`, `code_review`, `-deploy-`, `code--review`

### 2. Create the Directory Structure

```bash
mkdir -p skills/your-skill-name
touch skills/your-skill-name/SKILL.md
```

Optional subdirectories:
```bash
mkdir -p skills/your-skill-name/scripts     # Executable code
mkdir -p skills/your-skill-name/references  # Additional docs
mkdir -p skills/your-skill-name/assets      # Templates, images
```

### 3. Write the SKILL.md

Use this template:

```markdown
---
name: your-skill-name
description: Clear, concise description of what this skill does and when to use it. Include relevant keywords.
license: MIT
compatibility: Works with Claude Code and OpenAI Codex. List any specific requirements here.
metadata:
  category: skill-category
  tags: tag1, tag2, tag3
  version: "1.0.0"
---

# Your Skill Name

## Overview

Brief overview of what this skill accomplishes.

## When to Use

Describe the scenarios where this skill should be invoked.

## Process

Step-by-step instructions for the agent to follow:

1. Step one
2. Step two
3. Step three

## Examples

Show the skill in action with concrete examples.

## Additional Resources

For detailed examples, see [references/EXAMPLES.md](references/EXAMPLES.md).
```

### 4. Keep It Concise

- Main SKILL.md should be **under 500 lines**
- Move detailed examples to `references/EXAMPLES.md`
- Move code/scripts to `scripts/` directory
- Move templates/data to `assets/` directory

### 5. Validate Your Skill

Before submitting:

```bash
# Install dependencies (one-time)
uv sync

# Validate your skill
uv run skills-ref validate ./skills/your-skill-name

# Or validate all skills
./scripts/validate-skills.sh
```

Fix any validation errors before committing.

### 6. Test Your Skill

#### Test with Claude Code

```bash
claude --plugin-dir /path/to/supaviber
```

Trigger scenarios where your skill should activate. Verify it works as expected.

#### Test with OpenAI Codex

```bash
# Link your skill to Codex
ln -s /path/to/supaviber/skills/your-skill-name ~/.codex/skills/your-skill-name

# Verify it's discovered
codex skills list

# Test in context
codex
```

### 7. Submit Your Contribution

```bash
git checkout -b feat/add-your-skill-name
git add skills/your-skill-name
git commit -m "feat: add your-skill-name skill"
git push origin feat/add-your-skill-name
```

Then open a pull request with:
- Clear description of what the skill does
- When and why to use it
- Any dependencies or requirements
- Testing steps you performed

## Skill Best Practices

### Writing Effective Descriptions

The `description` field is critical - it's how agents decide when to use your skill.

**Good descriptions**:
- "Review code for security vulnerabilities, performance issues, and best practices. Use when analyzing codebases or reviewing pull requests."
- "Deploy applications to production with safety checks. Use when deploying, releasing, or shipping code."

**Bad descriptions**:
- "Code review" (too vague)
- "Does various code things" (not actionable)

### Organizing Large Skills

If your skill exceeds 400 lines, consider splitting it:

1. **Keep in SKILL.md**: Core workflow, essential instructions
2. **Move to references/**: Detailed examples, edge cases, supplementary docs
3. **Move to scripts/**: Executable code, validation logic
4. **Move to assets/**: Templates, configuration files, lookup tables

Example:
```
deployment-skill/
├── SKILL.md                    # Core deployment process (~300 lines)
├── scripts/
│   ├── validate-env.sh        # Environment validation
│   └── rollback.py            # Rollback automation
├── references/
│   ├── TROUBLESHOOTING.md     # Common issues and fixes
│   └── EXAMPLES.md            # Deployment scenarios
└── assets/
    └── deploy-config.yaml     # Configuration template
```

### Adding Scripts

Scripts should:
- Be executable: `chmod +x scripts/your-script.sh`
- Include shebang: `#!/usr/bin/env bash` or `#!/usr/bin/env python3`
- Provide helpful error messages
- Exit with appropriate codes (0 = success, non-zero = failure)
- Document usage in comments

### Using References

Reference additional docs from SKILL.md:
```markdown
For detailed code examples, see [references/EXAMPLES.md](references/EXAMPLES.md).
For troubleshooting, see [references/TROUBLESHOOTING.md](references/TROUBLESHOOTING.md).
```

Keep references focused (<500 lines each) and one level deep (no nested subdirectories).

## Code Review Checklist

Before requesting review, ensure:

- [ ] Skill name follows naming conventions
- [ ] Directory name matches skill name exactly
- [ ] Frontmatter includes all required fields (`name`, `description`)
- [ ] Frontmatter includes `license: MIT`
- [ ] Main SKILL.md is under 500 lines
- [ ] Long content moved to `references/`
- [ ] Scripts are executable and documented
- [ ] Skill passes `uv run skills-ref validate`
- [ ] Tested with Claude Code
- [ ] Tested with OpenAI Codex (if available)
- [ ] README updated if adding new category
- [ ] CHANGELOG.md updated

## Questions?

- Read the [Agent Skills Specification](https://agentskills.io/specification)
- Check existing skills for examples
- Open an issue for clarification

Thank you for contributing! 🎵
