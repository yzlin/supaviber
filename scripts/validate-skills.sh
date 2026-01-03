#!/usr/bin/env bash
# Validates all skills in the skills/ directory against agent skills spec
# Uses skills-ref library for validation

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
SKILLS_DIR="$PROJECT_ROOT/skills"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "Validating SupaViber skills against agent skills specification..."
echo "Skills directory: $SKILLS_DIR"
echo ""

# Ensure uv is installed
if ! command -v uv &> /dev/null; then
    echo -e "${RED}Error: uv is not installed.${NC}"
    echo "Install with: curl -LsSf https://astral.sh/uv/install.sh | sh"
    exit 1
fi

# Install dependencies if needed
if [ ! -d "$PROJECT_ROOT/.venv" ]; then
    echo -e "${YELLOW}Installing dependencies...${NC}"
    cd "$PROJECT_ROOT"
    uv sync
    echo ""
fi

# Activate virtual environment and check for skills-ref
SKILLS_REF_CMD="$PROJECT_ROOT/.venv/bin/skills-ref"
if [ ! -f "$SKILLS_REF_CMD" ]; then
    echo -e "${RED}Error: skills-ref not found in virtual environment.${NC}"
    echo "Run: uv sync"
    exit 1
fi

# Track validation results
TOTAL_SKILLS=0
PASSED_SKILLS=0
FAILED_SKILLS=0

# Validate each skill directory
for skill_dir in "$SKILLS_DIR"/*/; do
    if [ -d "$skill_dir" ]; then
        skill_name=$(basename "$skill_dir")

        # Skip README.md or non-skill directories
        if [ "$skill_name" = "README.md" ] || [ ! -f "$skill_dir/SKILL.md" ]; then
            continue
        fi

        TOTAL_SKILLS=$((TOTAL_SKILLS + 1))
        echo -e "Validating skill: ${YELLOW}$skill_name${NC}"

        # Run skills-ref validation
        if "$SKILLS_REF_CMD" validate "$skill_dir" 2>&1; then
            echo -e "${GREEN}✓ $skill_name passed validation${NC}"
            PASSED_SKILLS=$((PASSED_SKILLS + 1))
        else
            echo -e "${RED}✗ $skill_name failed validation${NC}"
            FAILED_SKILLS=$((FAILED_SKILLS + 1))
        fi
        echo ""
    fi
done

# Summary
echo "========================================"
echo "Validation Summary:"
echo "  Total skills: $TOTAL_SKILLS"
echo -e "  ${GREEN}Passed: $PASSED_SKILLS${NC}"
echo -e "  ${RED}Failed: $FAILED_SKILLS${NC}"
echo "========================================"

# Exit with error if any failed
if [ $FAILED_SKILLS -gt 0 ]; then
    exit 1
fi

exit 0
