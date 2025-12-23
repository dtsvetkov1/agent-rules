# Mobile Development MCPs

A curated list of Model Context Protocol (MCP) servers tailored for mobile development. These tools enhance your AI coding assistant's capabilities with mobile-specific context and automation.

## Core MCPs

### 1. Mobile MCP Next

**Description:**
A comprehensive MCP server designed for mobile automation and scraping across iOS, Android, emulators, simulators, and real devices. It allows your AI agent to interact with running mobile applications.

**Installation:**

**Cursor:**

<a href="cursor://anysphere.cursor-deeplink/mcp/install?name=mobile-mcp&config=eyJjb21tYW5kIjogIm5weCIsICJhcmdzIjogWyIteSIsICJAbW9iaWxlbmV4dC9tb2JpbGUtbWNwQGxhdGVzdCJdfQ%3D%3D"><img src="https://cursor.com/deeplink/mcp-install-light.png" alt="Add mobile-mcp to Cursor" style="max-height: 32px;" /></a>

**Other (Manual Configuration):**
<details>
<summary>JSON Configuration</summary>

```json
{
  "command": "npx",
  "args": [
    "-y",
    "@mobilenext/mobile-mcp@latest"
  ]
}
```
</details>

**Claude Code:**
```bash
claude mcp add mobile-mcp -- npx -y @mobilenext/mobile-mcp@latest
```

---

### 2. Playwright MCP

**Description:**
Integrates Playwright for browser automation. 

**Installation:**

**Cursor:**

<a href="cursor://anysphere.cursor-deeplink/mcp/install?name=playwright-mcp&config=eyJjb21tYW5kIjogIm5weCIsICJhcmdzIjogWyIteSIsICJwbGF5d3JpZ2h0LW1jcEBsYXRlc3QiXX0%3D"><img src="https://cursor.com/deeplink/mcp-install-light.png" alt="Add playwright-mcp to Cursor" style="max-height: 32px;" /></a>

**Claude Code:**
```bash
claude mcp add playwright-mcp -- npx -y playwright-mcp@latest
```

**Other (Manual Configuration):**
<details>
<summary>JSON Configuration</summary>

```json
{
  "command": "npx",
  "args": [
    "-y",
    "playwright-mcp@latest"
  ]
}
```
</details>

---

### 3. Framelink Figma MCP

**Description:**
Provides Figma layout information to AI coding agents. This allows your agent to read design specs and generate React Native components directly from your Figma files.

**Installation:**

**Cursor:**

<a href="cursor://anysphere.cursor-deeplink/mcp/install?name=figma-mcp&config=eyJjb21tYW5kIjogIm5weCIsICJhcmdzIjogWyIteSIsICJmaWdtYS1kZXZlbG9wZXItbWNwIiwgIi0tZmlnbWEtYXBpLWtleT1ZT1VSLUtFWSIsICItLXN0ZGlvIl19"><img src="https://cursor.com/deeplink/mcp-install-light.png" alt="Add figma-mcp to Cursor" style="max-height: 32px;" /></a>

*Note: You will need to replace `YOUR-KEY` with your actual Figma API key in the configuration after installation if the button doesn't prompt for it.*

**Claude Code:**
```bash
claude mcp add figma-mcp -- npx -y figma-developer-mcp --figma-api-key=YOUR-KEY --stdio
```

**Other (Manual Configuration):**
<details>
<summary>JSON Configuration</summary>

```json
{
  "command": "npx",
  "args": [
    "-y",
    "figma-developer-mcp",
    "--figma-api-key=YOUR-KEY",
    "--stdio"
  ]
}
```
</details>


---

### 4. Expo MCP

**Description:**
The official Expo MCP server. It gives your AI agent deep context about your Expo project, including EAS configuration, dependencies, and documentation.

**Installation:**

**Cursor:**

<a href="cursor://anysphere.cursor-deeplink/mcp/install?name=expo-mcp&config=eyJ1cmwiOiAiaHR0cHM6Ly9tY3AuZXhwby5kZXYvbWNwIiwgInRyYW5zcG9ydCI6ICJzc2UifQ%3D%3D"><img src="https://cursor.com/deeplink/mcp-install-light.png" alt="Add expo-mcp to Cursor" style="max-height: 32px;" /></a>

**Claude Code:**
```bash
claude mcp add --transport http expo-mcp https://mcp.expo.dev/mcp
```


**Manual Configuration:**
<details>
<summary>JSON Configuration</summary>

```json
{
  "url": "https://mcp.expo.dev/mcp",
  "transport": "sse"
}
```
</details>


---

## Opinionated & Optional

These are optional but highly recommended for a supercharged workflow.

### 5. Perplexity MCP

**Description:**
Adds real-time web search capabilities to your coding assistant. Great for looking up the latest React Native libraries, Expo SDK updates, or debugging obscure errors.

**Installation:**

**Cursor:**

<a href="cursor://anysphere.cursor-deeplink/mcp/install?name=perplexity-mcp&config=eyJjb21tYW5kIjogIm5weCIsICJhcmdzIjogWyIteSIsICJwZXJwbGV4aXR5LW1jcEBsYXRlc3QiXX0%3D"><img src="https://cursor.com/deeplink/mcp-install-light.png" alt="Add perplexity-mcp to Cursor" style="max-height: 32px;" /></a>


**Claude Code:**
```bash
claude mcp add perplexity-mcp -- npx -y perplexity-mcp@latest
```

**Manual Configuration:**
<details>
<summary>JSON Configuration</summary>

```json
{
  "command": "npx",
  "args": [
    "-y",
    "perplexity-mcp@latest"
  ]
}
```
</details>


---

### 6. Serena MCP

**Description:**
An advanced MCP for managing development workflows, providing enhanced project context and task management capabilities.

**Installation:**

**Cursor:**

<a href="cursor://anysphere.cursor-deeplink/mcp/install?name=serena-mcp&config=eyJjb21tYW5kIjogIm5weCIsICJhcmdzIjogWyIteSIsICJzZXJlbmEtbWNwQGxhdGVzdCJdfQ%3D%3D"><img src="https://cursor.com/deeplink/mcp-install-light.png" alt="Add serena-mcp to Cursor" style="max-height: 32px;" /></a>


**Claude Code:**
```bash
claude mcp add serena-mcp -- npx -y serena-mcp@latest
```


**Other (Manual Configuration):**
<details>
<summary>JSON Configuration</summary>

```json
{
  "command": "npx",
  "args": [
    "-y",
    "serena-mcp@latest"
  ]
}
```
</details>

## How to Use

Once installed, restart your editor (Cursor) or reload your agent (Claude Code). You can then ask your AI assistant questions like:

- "Check the mobile emulator for running apps" (Mobile MCP)
- "Read the layout from this Figma file and create a component" (Figma MCP)
- "What is the latest way to configure EAS Build?" (Expo MCP / Perplexity)
