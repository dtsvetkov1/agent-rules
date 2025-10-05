# React Native Expo AI Agent Rules

An opinionated set of AI coding guidelines and commands for React Native Expo projects. These rules help AI assistants (like Cursor, Claude, ChatGPT) generate consistent, high-quality code following best practices.

## Quick Start

### Automated Installation

Run this one-liner in your React Native Expo project root:

```bash
curl -fsSL https://raw.githubusercontent.com/dtsvetkov1/agent-rules/main/setup.sh | bash
```

Or download and run the script manually:

```bash
curl -fsSL https://raw.githubusercontent.com/dtsvetkov1/agent-rules/main/setup.sh -o setup.sh
chmod +x setup.sh
./setup.sh
```

### Manual Installation

If you prefer to install manually, just download the needed files from the repository and put them in your project

## What Gets Installed

After installation, your project will have:

```
your-project/
├── AGENTS.md                           # Main AI coding guidelines (https://agents.md/)
├── .cursor/
│   ├── rules/
│   │   └── react-native-expo-guidelines.mdc  # Cursor-specific rules
│   ├── commands/                       # Command templates for common workflows (https://cursor.com/docs/agent/chat/commands)
│   │   ├── code-review-checklist.md    # Review checklist
│   │   ├── ...
│   ├── hooks.json                      # Hook configuration
│   └── hooks/                          # Hook scripts that run automatically after certain actions (https://cursor.com/docs/agent/hooks)
│       ├── audit.sh                    # Audit agent actions
│       ├── ...
```

## What's Inside

### Core Guidelines (AGENTS.md)

Comprehensive guidelines covering:

- **Tech Stack**: Bun, TypeScript, Expo Router, Zustand, Reanimated
- **Project Structure**: Directory organization and naming conventions
- **Component Patterns**: Best practices for React Native components
- **State Management**: Zustand patterns and store organization
- **Animations**: React Native Reanimated guidelines
- **Performance**: Optimization techniques and best practices
- **Security**: Secure coding practices and data protection
- **Testing**: Unit, integration, and E2E testing strategies

### Quick Reference

#### Must-Use Technologies

- Bun (package manager)
- TypeScript (all files)
- Expo Router (navigation)
- Zustand (state management)
- React Native Reanimated (animations)
- expo/fetch (HTTP requests)
- NativeWind (styling)

### Command Templates

Pre-built workflows for common tasks:

- **setup-new-feature**: Systematic feature development
- **code-review-checklist**: Ensure code quality before PR
- **security-audit**: Security best practices validation
- **build-deploy**: Build and deployment workflows
- **run-tests-fix-failures**: Testing and debugging
- **code-quality**: Code quality analysis
- **update-documentation**: Documentation maintenance

### Cursor Hooks

AI agent lifecycle hooks for safety and quality:

- **format.sh**: Auto-formats edited files with Prettier/ESLint
- **audit.sh**: Logs all agent actions to `~/.cursor/audit/agent-audit.log`
- **block-dangerous-git.sh**: Prevents force pushes to main/master and other risky git operations
- **check-secrets.sh**: Scans prompts for API keys, tokens, and secrets before submission

Hooks run automatically and require a Cursor restart after installation. Check the Hooks tab in Cursor Settings to debug.

## Usage

### With Cursor AI

1. Install the rules using the setup script
2. Open your project in Cursor
3. Start coding - the AI will automatically follow `react-native-expo-guidelines.mdc` rules (its configured to always apply, feel free to change it if needed)
4. Use command templates from `.cursor/commands/` for common workflows with `/` prefix, like `/run-tests-fix-failures` for running tests and fixing failures, or `/update-documentation` for updating documentation

### With Other AI Assistants

1. Share the `AGENTS.md` file with your AI assistant (Claude, ChatGPT, Cursor, etc.)
2. Reference specific sections when asking for code generation
3. Use the guidelines as a reference for code reviews (if needed)

## Customization

After installation, feel free to customize the rules for your specific project:

1. Edit `AGENTS.md` to match your project structure or specific needs
2. Update `.cursor/rules/` for Cursor-specific preferences
3. Modify command templates in `.cursor/commands/`
4. Commit changes to your repository if needed

---

Created for React Native Expo projects to ensure consistent, high-quality AI-assisted development.

## TODO/improvements

- add option to download only certain files or directories
- add additional configs for claude code (subagents, hooks, output styles etc)
