#!/usr/bin/env bash
# Interactive skill generator - creates a new skill from template

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
SKILLS_DIR="$PROJECT_ROOT/skills"
TEMPLATE_DIR="$PROJECT_ROOT/.templates/skill-template"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo "========================================"
echo "  SupaViber Skill Generator"
echo "========================================"
echo ""

# Validate skill name
validate_name() {
    local name=$1

    # Check length
    if [ ${#name} -lt 1 ] || [ ${#name} -gt 64 ]; then
        echo -e "${RED}Error: Name must be 1-64 characters${NC}"
        return 1
    fi

    # Check format (lowercase, alphanumeric, hyphens)
    if ! [[ "$name" =~ ^[a-z0-9]+(-[a-z0-9]+)*$ ]]; then
        echo -e "${RED}Error: Name must be lowercase alphanumeric with hyphens (no consecutive hyphens, no leading/trailing hyphens)${NC}"
        return 1
    fi

    # Check if already exists
    if [ -d "$SKILLS_DIR/$name" ]; then
        echo -e "${RED}Error: Skill '$name' already exists${NC}"
        return 1
    fi

    return 0
}

# Get skill name
while true; do
    read -p "Skill name (lowercase, hyphens only): " skill_name
    if validate_name "$skill_name"; then
        break
    fi
done

# Get description
while true; do
    read -p "Description (1-1024 chars): " description
    if [ ${#description} -ge 1 ] && [ ${#description} -le 1024 ]; then
        break
    else
        echo -e "${RED}Error: Description must be 1-1024 characters${NC}"
    fi
done

# Get category
read -p "Category (default: general): " category
category=${category:-general}

# Get tags
read -p "Tags (comma-separated): " tags

# Create skill directory
skill_dir="$SKILLS_DIR/$skill_name"
echo ""
echo -e "${YELLOW}Creating skill: $skill_name${NC}"
mkdir -p "$skill_dir"

# Copy and customize template
if [ -f "$TEMPLATE_DIR/SKILL.md" ]; then
    cp "$TEMPLATE_DIR/SKILL.md" "$skill_dir/SKILL.md"

    # Replace placeholders (macOS compatible)
    if [[ "$OSTYPE" == "darwin"* ]]; then
        sed -i '' "s/name: skill-name/name: $skill_name/" "$skill_dir/SKILL.md"
        sed -i '' "s/description: .*/description: $description/" "$skill_dir/SKILL.md"
        sed -i '' "s/category: general/category: $category/" "$skill_dir/SKILL.md"
        sed -i '' "s/tags: tag1, tag2, tag3/tags: $tags/" "$skill_dir/SKILL.md"
        sed -i '' "s/# Skill Name/# ${skill_name^}/" "$skill_dir/SKILL.md"
    else
        sed -i "s/name: skill-name/name: $skill_name/" "$skill_dir/SKILL.md"
        sed -i "s/description: .*/description: $description/" "$skill_dir/SKILL.md"
        sed -i "s/category: general/category: $category/" "$skill_dir/SKILL.md"
        sed -i "s/tags: tag1, tag2, tag3/tags: $tags/" "$skill_dir/SKILL.md"
        sed -i "s/# Skill Name/# ${skill_name^}/" "$skill_dir/SKILL.md"
    fi
else
    echo -e "${RED}Error: Template not found at $TEMPLATE_DIR/SKILL.md${NC}"
    exit 1
fi

# Ask about optional directories
echo ""
read -p "Create scripts/ directory? (y/N): " create_scripts
if [[ "$create_scripts" =~ ^[Yy]$ ]]; then
    mkdir -p "$skill_dir/scripts"
    touch "$skill_dir/scripts/.gitkeep"
    echo -e "${GREEN}✓ Created scripts/ directory${NC}"
fi

read -p "Create references/ directory? (y/N): " create_refs
if [[ "$create_refs" =~ ^[Yy]$ ]]; then
    mkdir -p "$skill_dir/references"
    cat > "$skill_dir/references/EXAMPLES.md" << 'EOF'
# Examples

## Example 1: Basic Usage

Describe a basic use case here.

## Example 2: Advanced Usage

Describe an advanced scenario here.
EOF
    echo -e "${GREEN}✓ Created references/ directory with EXAMPLES.md${NC}"
fi

read -p "Create assets/ directory? (y/N): " create_assets
if [[ "$create_assets" =~ ^[Yy]$ ]]; then
    mkdir -p "$skill_dir/assets"
    touch "$skill_dir/assets/.gitkeep"
    echo -e "${GREEN}✓ Created assets/ directory${NC}"
fi

echo ""
echo -e "${GREEN}✓ Skill created successfully!${NC}"
echo ""
echo "Next steps:"
echo "  1. Edit $skill_dir/SKILL.md"
echo "  2. Add your skill instructions and examples"
echo "  3. Validate: uv run skills-ref validate $skill_dir"
echo "  4. Test with: claude --plugin-dir $PROJECT_ROOT"
echo ""
echo "See CONTRIBUTING.md for detailed guidelines."
