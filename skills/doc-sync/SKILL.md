---
name: doc-sync
description: Ensures that documentation files like README.md and AGENTS.md stay in sync with the actual code and project structure. Use when adding new features or changing project architecture.
---

# Doc Sync Skill

This skill helps maintain the "Source of Truth" in your documentation.

## Instructions

1. **Verify Structure**: Compare the actual directory structure with what is documented in `README.md`.
2. **Update Guidelines**: If a new library is added (e.g., a new state manager), update `AGENTS.md`, `.cursor/rules/` and `docs/` files if needed.
3. **Cross-Reference**: Ensure that links between documentation files are valid.
4. **Version Sync**: Keep version numbers in `package.json` and documentation consistent.

## Best Practices

- Keep `README.md` focused on setup and high-level architecture.
- Use `AGENTS.md` for AI-specific instructions and coding patterns.
- Regularly update `MCP.md` if new tools are added to the environment.
