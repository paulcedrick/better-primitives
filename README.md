# Better Plan Mode

A Claude Code plugin that enhances planning by making Claude proactively ask in-depth questions before making assumptions.

## What It Does

- **Asks questions before exploring code** - Clarifies requirements and intent first
- **Asks questions after exploring code** - Surfaces technical decisions that need input
- **Confirms understanding before planning** - Summarizes and validates before proceeding
- **Uses AskUserQuestion tool** - Structured questions with clear options

## Installation

### From GitHub

```bash
# Add the marketplace
/plugin marketplace add https://github.com/YOUR_USERNAME/better-plan-mode.git

# Install the plugin
/plugin install better-plan-mode@better-plan-mode
```

### Local Testing

```bash
claude --plugin-dir /path/to/better-plan-mode
```

## Usage

### Explicit Planning

Use the `/plan` command to start enhanced planning:

```
/plan Add user authentication to the app
```

Claude will:

1. Ask clarifying questions about requirements
2. Explore your codebase
3. Ask technical questions based on what it found
4. Confirm understanding
5. Present a focused implementation plan

### Automatic Behavior

The `thorough-planning` skill also activates automatically when Claude detects:

- Feature implementation requests
- Ambiguous requirements
- Multiple valid approaches

## Question Categories

The plugin guides Claude to ask about:

| Category         | Example Questions                                      |
| ---------------- | ------------------------------------------------------ |
| **Requirements** | What exactly should be built? What are the edge cases? |
| **Scope**        | MVP or production-ready? What's in vs out of scope?    |
| **Technical**    | Which patterns to follow? Which libraries to use?      |

## Example Interaction

```
User: /plan Add a settings page

Claude: Before I explore your codebase, I want to understand what you need.

[AskUserQuestion]
- What settings should users be able to configure?
- Should settings persist locally or sync across devices?
- Any specific UI framework preferences?

User: [Answers questions]

Claude: I've explored your codebase. I see you're using React with Tailwind.

[AskUserQuestion]
- Should I follow your existing page layout pattern from Dashboard.tsx?
- I noticed you use React Query for state. Use that for settings too?

User: [Answers questions]

Claude: Here's my understanding:
- Settings page with theme, notifications, and account preferences
- Local storage for now, sync later
- Following existing React/Tailwind patterns

Is this correct?

User: Yes

Claude: [Presents focused implementation plan]
```

## Plugin Structure

```
better-plan-mode/
├── .claude-plugin/
│   └── plugin.json
├── commands/
│   └── plan.md
├── skills/
│   └── thorough-planning/
│       └── SKILL.md
└── README.md
```

## License

MIT
