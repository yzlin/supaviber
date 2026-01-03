# Metadata Conventions

This document defines standard metadata conventions for SupaViber skills to ensure consistency and better discoverability.

## Metadata Structure

```yaml
metadata:
  category: category-name
  tags: tag1, tag2, tag3
  version: "MAJOR.MINOR.PATCH"
  author: Optional author name
  created: YYYY-MM-DD
  updated: YYYY-MM-DD
```

## Standard Categories

Use these categories for consistency:

- `version-control` - Git, SVN, version control workflows
- `code-quality` - Linting, formatting, code standards
- `testing` - Test generation, coverage, validation
- `deployment` - CI/CD, deployment, release workflows
- `security` - Security scanning, vulnerability checks
- `documentation` - Docs generation, API documentation
- `debugging` - Debugging workflows, troubleshooting
- `performance` - Performance optimization, profiling
- `collaboration` - Team workflows, code review
- `general` - General-purpose or uncategorized

## Tagging Guidelines

Tags should be:
- Lowercase
- Comma-separated
- Relevant keywords for discovery
- Specific to the skill's domain

**Examples**:
- `tags: git, safety, collaboration, destructive-operations`
- `tags: clean-code, SOLID, DRY, best-practices, design-patterns`
- `tags: deployment, ci-cd, production, automation`

## Versioning

Follow [Semantic Versioning](https://semver.org/):

- `MAJOR`: Breaking changes to skill interface/behavior
- `MINOR`: New features, backward-compatible
- `PATCH`: Bug fixes, documentation updates

**Examples**:
- `version: "1.0.0"` - Initial stable release
- `version: "1.1.0"` - Added new capability
- `version: "1.1.1"` - Fixed bug in existing feature
- `version: "2.0.0"` - Changed skill invocation behavior

## Optional Fields

### author
Skill creator or maintainer:
```yaml
metadata:
  author: Jane Doe
```

### created / updated
Track when skill was created/modified:
```yaml
metadata:
  created: 2025-12-27
  updated: 2026-01-02
```

### license (top-level)
Prefer top-level `license` field over metadata:
```yaml
license: MIT
```

### compatibility (top-level)
Prefer top-level `compatibility` field:
```yaml
compatibility: Works with Claude Code and OpenAI Codex. Requires git CLI access.
```

## Complete Example

```yaml
---
name: git-safety
description: Apply critical git safety protocols before any git operations, especially in collaborative environments.
license: MIT
compatibility: Works with Claude Code and OpenAI Codex. Requires git CLI access.
metadata:
  category: version-control
  tags: git, safety, collaboration, destructive-operations
  version: "1.0.0"
  author: SupaViber Team
  created: 2025-12-27
  updated: 2026-01-02
---
```

## Validation

All metadata fields are optional but recommended for better skill discovery and organization.

Validate your metadata:
```bash
skills-ref validate ./skills/your-skill
```

## Best Practices

1. **Be specific with categories** - Choose the most relevant category
2. **Use meaningful tags** - Think about what users would search for
3. **Version incrementally** - Follow semver strictly
4. **Update timestamps** - Keep `updated` field current when modifying skills
5. **Consistent naming** - Use lowercase, hyphenated tags
