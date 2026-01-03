# Changelog

All notable changes to the SupaViber plugin will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.3.0] - 2026-01-03
### Added
- OpenAI Codex compatibility - skills now follow Agent Skills open standard
- Dual platform support (Claude Code + OpenAI Codex)
- `compatibility` and `metadata` frontmatter fields to all skills
- `references/` subdirectory support for on-demand documentation
- Skill validation script (`scripts/validate-skills.sh`)
- GitHub Actions workflow for automated skill validation
- `CONTRIBUTING.md` with comprehensive skill creation guidelines
- Pre-commit hook for skill validation (optional, via `hooks/hooks.json`)
- Skill template (`.templates/skill-template/SKILL.md`)
- Interactive skill generator (`scripts/create-skill.sh`)
- Metadata conventions documentation (`docs/METADATA-CONVENTIONS.md`)

### Changed
- Refactored `coding-standards` skill to use references/ directory (786 → 525 lines)
- Updated `git-safety` skill with full metadata (license, compatibility, metadata)
- Enhanced README with dual compatibility documentation
- Updated all documentation to reference Agent Skills specification

### Improved
- Skills now validated against agent skills specification
- Better organization with scripts/, references/, assets/ directories support
- Cross-platform compatibility documentation
- Reduced skill file sizes for better context efficiency

## [0.2.0] - 2025-12-29
### Added
- Marketplace configuration (marketplace.json)
- Support for `/plugin marketplace add` installation
- Git safety skill with comprehensive protocols
- Coding standards skill with SOLID principles and best practices
- Updated documentation with marketplace installation and skill descriptions

### Fixed
- Marketplace source path format validation

## [0.1.0] - 2025-12-27
### Added
- Initial release
- Plugin manifest configuration
- Complete directory structure (skills/, agents/, commands/, hooks/, scripts/)
- README documentation
- MIT license
- Git repository initialization
