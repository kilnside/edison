#!/bin/bash
# Installs three skills: Edison, Edison Evolve, and Product Forge
set -e

SKILLS_DIR="${HOME}/.claude/skills"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

mkdir -p "${SKILLS_DIR}/edison/resources" \
         "${SKILLS_DIR}/edison-evolve" \
         "${SKILLS_DIR}/product-forge/references"

cp "${SCRIPT_DIR}/SKILL.md" "${SKILLS_DIR}/edison/SKILL.md"
cp "${SCRIPT_DIR}/resources/"* "${SKILLS_DIR}/edison/resources/"
cp "${SCRIPT_DIR}/edison-evolve/SKILL.md" "${SKILLS_DIR}/edison-evolve/SKILL.md"
cp "${SCRIPT_DIR}/product-forge/SKILL.md" "${SKILLS_DIR}/product-forge/SKILL.md"
cp "${SCRIPT_DIR}/product-forge/references/"* "${SKILLS_DIR}/product-forge/references/"

echo "Installed: edison, edison-evolve, product-forge"
echo "Run /edison, /edison evolve, or /product-forge in any project."
