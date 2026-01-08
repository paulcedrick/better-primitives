# Better Primitives

A Claude Code plugin providing enhanced planning, debugging, analysis, and software architecture design with subagent-powered exploration and confidence-driven approaches.

## What's New in v2.0

- **Subagent delegation**: Commands now delegate exploration tasks to subagents for cost efficiency and parallelism
- **Model selection**: Uses Sonnet/Haiku for exploration, Opus for synthesis
- **Simplified architecture**: Commands-only structure (no separate skills)
- **~70% token reduction**: Streamlined instructions without losing impact

## Commands

| Command                      | Description                                             |
| ---------------------------- | ------------------------------------------------------- |
| `/better-primitives:plan`    | Enhanced planning with subagent exploration             |
| `/better-primitives:debug`   | Parallel hypothesis testing with subagent investigation |
| `/better-primitives:analyze` | Code analysis with subagent-powered pattern detection   |
| `/better-primitives:design`  | Architecture design with ATAM-style risk analysis       |

## Installation

### Quick Install (One-liner)

```bash
curl -fsSL https://raw.githubusercontent.com/paulcedrick/better-primitives/main/install.sh | bash
```

### From GitHub

```bash
claude plugin install paulcedrick/better-primitives
```

### Local Development

```bash
git clone https://github.com/paulcedrick/better-primitives.git
cd better-primitives
claude plugin install .
```

## Usage

### Plan Command

```
/better-primitives:plan Add user authentication to the app
```

Claude will:

1. Ask clarifying questions about requirements
2. **Delegate codebase exploration to Sonnet subagent**
3. Synthesize findings and ask technical questions
4. Present implementation plan when confidence reaches HIGH (80+)

### Debug Command

```
/better-primitives:debug The API returns 500 errors intermittently
```

Claude will:

1. Gather symptoms with clarifying questions
2. Form hypotheses and present them
3. **Launch parallel subagents to test hypotheses**
4. Present root cause when confidence reaches HIGH (75+)

### Analyze Command

```
/better-primitives:analyze performance of the API handlers
```

Claude will:

1. Understand improvement goals
2. **Delegate code exploration to subagents (parallel)**
3. Present findings with Impact/Effort prioritization
4. Validate findings and discuss trade-offs
5. Offer implementation plan

### Design Command

```
/better-primitives:design the authentication system
```

Claude will:

1. Gather context about purpose and stakeholders
2. **Use subagents for component discovery and flow analysis**
3. Document architecture with Mermaid/ASCII diagrams
4. Analyze risks (ATAM-style) and trade-offs (ADR-style)
5. Present design when confidence reaches HIGH (80+)

## Subagent Model Selection

| Task Type               | Model  | Rationale                          |
| ----------------------- | ------ | ---------------------------------- |
| File search (Glob/Grep) | Haiku  | Fast, cheap, simple                |
| Code analysis           | Sonnet | Good comprehension, cost-effective |
| Hypothesis testing      | Sonnet | Can reason, cheaper than Opus      |
| User interaction        | Opus   | Best judgment, nuanced responses   |
| Final synthesis         | Opus   | High-quality output                |

## Structure

```
better-primitives/
├── .claude-plugin/
│   └── plugin.json
├── commands/
│   ├── plan.md      (~185 lines)
│   ├── debug.md     (~200 lines)
│   ├── analyze.md   (~220 lines)
│   └── design.md    (~270 lines)
└── README.md
```

## Key Features

- **Confidence metrics**: Numeric scoring (0-100) with clear thresholds
- **Subagent delegation**: Cost-effective exploration with model selection
- **Parallel execution**: Multiple exploration tasks run concurrently
- **ISO 25010 categories**: Standard quality characteristics for analysis
- **Impact/Effort matrix**: Prioritized findings
- **ATAM-style risks**: Architectural risk analysis
- **ADR-style trade-offs**: Decision documentation with rationale
- **Escape hatches**: Early presentation when user requests

## License

MIT
