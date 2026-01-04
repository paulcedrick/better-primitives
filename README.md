# Better Primitives

A Claude Code plugin providing enhanced planning, debugging, and analysis with thorough, question-driven approaches.

## Commands

| Command                      | Description                                                                                                                  |
| ---------------------------- | ---------------------------------------------------------------------------------------------------------------------------- |
| `/better-primitives:plan`    | Enhanced planning with thorough questioning                                                                                  |
| `/better-primitives:debug`   | Thorough debugging with confidence-scored investigation                                                                      |
| `/better-primitives:analyze` | Thorough analysis for improvements with confidence-scored investigation (ISO 25010 categories, Impact/Effort prioritization) |

## Installation

### From GitHub

```bash
claude plugin install paulcedrick/better-primitives
```

### Local Development

```bash
# Clone the repository
git clone https://github.com/paulcedrick/better-primitives.git
cd better-primitives

# Install locally
claude plugin install .
```

## Usage

### Plan Command

Use `/better-primitives:plan` to start enhanced planning:

```
/better-primitives:plan Add user authentication to the app
```

Claude will:

1. Ask clarifying questions about requirements
2. Explore your codebase
3. Ask technical questions based on what it found
4. Confirm understanding
5. Present a focused implementation plan

The `thorough-planning` skill also activates automatically when Claude detects ambiguous requirements or multiple valid approaches.

### Debug Command

Use `/better-primitives:debug` to start thorough debugging:

```
/better-primitives:debug The API returns 500 errors intermittently
```

Claude will:

1. Gather symptoms with clarifying questions
2. Form hypotheses and present them with confidence scores
3. Investigate code systematically, asking confirmation questions
4. Present root cause with evidence when confidence reaches HIGH (75+)

The `thorough-debugging` skill also activates automatically when Claude detects bug reports, error messages, or unexpected behavior.

### Analyze Command

Use `/better-primitives:analyze` to start thorough analysis for improvements:

```
/better-primitives:analyze performance of the API handlers
```

Claude will:

1. Gather understanding of what you want to improve with clarifying questions
2. Explore the target area and identify improvement opportunities
3. Ask about priorities, trade-offs, and scope boundaries
4. Validate findings with a second exploration pass
5. Present categorized findings with impact levels
6. Ask if you want an implementation plan

The `thorough-analysis` skill also activates automatically when Claude detects requests to improve, optimize, refactor, or enhance code.

Features include:

- **Numeric confidence scoring** (0-100) aligned with `/debug` and `/plan`
- **Walkthrough Protocol** - understand code before suggesting improvements
- **Impact/Effort Matrix** - prioritize findings by value vs cost
- **ISO 25010 Categories** - organize findings by standard quality characteristics
- **Common Improvement Patterns** - reference guide for code smells

## Structure

```
better-primitives/
├── .claude-plugin/
│   └── plugin.json
├── commands/
│   ├── plan.md
│   ├── debug.md
│   └── analyze.md
├── skills/
│   ├── thorough-planning/
│   │   └── SKILL.md
│   ├── thorough-debugging/
│   │   └── SKILL.md
│   └── thorough-analysis/
│       └── SKILL.md
└── README.md
```

## License

MIT
