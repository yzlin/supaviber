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

# Check if skills-ref is installed
if ! command -v skills-ref &> /dev/null; then
    echo -e "${YELLOW}Warning: skills-ref validator not found.${NC}"
    echo "Install with: npm install -g @agentskills/skills-ref"
    echo "Skipping validation..."
    exit 0
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
        if skills-ref validate "$skill_dir" 2>&1; then
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
