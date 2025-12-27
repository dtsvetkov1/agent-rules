# Agent Skills

This repository includes a set of specialized **Agent Skills** designed to enhance the capabilities of AI coding agents (like Cursor, Claude Code, or Codex) within this React Native Expo project. These skills follow the [Agent Skills specification](https://agentskills.io/specification).

## Overview

A "Skill" is a packaged set of instructions, references, and scripts that an AI agent can "activate" to perform specific, complex tasks with high reliability and adherence to project standards.

### How they work

1.  **Discovery**: Agents scan the `skills/` directory to identify available capabilities via the `SKILL.md` files.
2.  **Activation**: When a task matches a skill's description (e.g., "integrate an API" matches `api-expert`), the agent reads the full instructions in the corresponding `SKILL.md`.
3.  **Execution**: The agent follows the structured instructions, uses provided references (in `references/`), and executes scripts (in `scripts/`) to complete the task.

## Available Skills

| Skill | Directory | Description |
| :--- | :--- | :--- |
| **API Expert** | `skills/api-expert` | Professional backend integration using `expo/fetch` and React Query. |
| **Change Writer** | `skills/change-writer` | Generates clean changelogs and release notes from git history. |
| **Doc Sync** | `skills/doc-sync` | Maintains synchronization between code, `AGENTS.md`, and other docs. |
| **Mobile Perf** | `skills/mobile-perf` | Optimization strategies for lists, animations, and bundle size. |
| **Navigation Architect** | `skills/navigation-architect` | Expert implementation of Expo Router file-based navigation. |
| **Opinion Critic** | `skills/opinion-critic` | Provides critical feedback and architectural alternatives. |
| **Security Audit** | `skills/security-audit` | Scans for hardcoded secrets and insecure mobile patterns. |

## How to Use

### For Developers

You can explicitly ask the AI agent to use a specific skill to ensure it follows the project's best practices:

- *"Using the **api-expert** skill, implement a new service for fetching user posts."*
- *"Run a **security-audit** on the changes in the current PR."*
- *"I'm about to release version 1.2.0, use **change-writer** to generate the changelog."*

Or add the skills to your agent (Claude Code, Cursor) to allow models activate them only when needed.

### For AI Agents

1.  **Read the Frontmatter**: Always check the `name` and `description` in `skills/*/SKILL.md` to find the right tool for the job.
2.  **Follow Instructions**: Once a skill is selected, strictly adhere to the "Instructions" and "Core Principles" sections.
3.  **Utilize Resources**: Check the `references/` folder within the skill for deeper technical guidelines and `scripts/` for automation tools.

## Structure of a Skill

Each skill is organized as follows:

```text
skills/my-skill/
├── SKILL.md          # Required: Instructions and metadata (YAML frontmatter)
├── scripts/          # Optional: Executable scripts (bash, python, etc.)
├── references/       # Optional: Detailed technical docs or checklists
└── assets/           # Optional: Templates or static resources
```

---
*For more information on the standard, visit [agentskills.io](https://agentskills.io).*
