# Better Primitives

A Claude Code plugin providing enhanced planning, debugging, analysis, and software architecture design with subagent-powered exploration and confidence-driven approaches.

## What's New in v3.1

- **Shared Base Template**: Common patterns extracted to `_base.md` for consistency and maintainability
- **Standardized JSON Questions**: All `AskUserQuestion` calls use consistent JSON format across commands
- **Testing Strategy Questions**: Every command now asks how changes should be verified
- **Enhanced Factor Scoring**: File count thresholds now include qualitative sufficiency criteria
- **Parallelized Design Phase 4**: Assumption validation and risk analysis run concurrently
- **Cleaner Phase Structure**: plan.md reorganized with clearer phase names (Approach Selection, Deep Validation)

### v3.0 Features (retained)

- **Execution Subagent**: Plans can now be automatically executed by an opus subagent
- **Web Research**: Phase 2 now includes web research for best practices and documentation
- **Hybrid Cost Model**: Haiku triage → Sonnet analysis → Opus escalation pattern reduces costs by ~35%
- **Pre-flight Checks**: New Phase 0.5 validates repository health before planning
- **Complexity Scoring**: New Phase 5.5 scores implementation complexity before execution
- **Context Optimization**: Main thread never reads files directly - all exploration via subagents

### v2.0 Features (retained)

- **Subagent delegation**: Commands delegate exploration tasks to subagents for cost efficiency
- **Model selection**: Uses Haiku/Sonnet for exploration, Opus for synthesis and execution
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

1. **Pre-flight check** - Verify repository health (haiku subagent)
2. Ask clarifying questions about requirements (including testing strategy)
3. **Parallel exploration** - 5 subagents for file search, test discovery, code analysis, approach testing, and web research
4. **Approach selection** - Present options with trade-offs, get user decision
5. **Deep validation** - Flow analysis and risk assessment (opus subagents in parallel)
6. **Plan review** - Sonnet validates plan quality before presentation
7. **Complexity scoring** - Score implementation difficulty before execution
8. **Optional execution** - Launch opus subagent to implement the plan autonomously

### Debug Command

```
/better-primitives:debug The API returns 500 errors intermittently
```

Claude will:

1. Gather symptoms with clarifying questions (including testing strategy)
2. Form hypotheses and present them
3. **Launch parallel subagents to test hypotheses**
4. Present root cause when confidence reaches HIGH (75+)

### Analyze Command

```
/better-primitives:analyze performance of the API handlers
```

Claude will:

1. Understand improvement goals (including testing strategy)
2. **Delegate code exploration to subagents (parallel)**
3. Present findings with Impact/Effort prioritization
4. Validate findings and discuss trade-offs
5. Offer implementation plan

### Design Command

```
/better-primitives:design the authentication system
```

Claude will:

1. Gather context about purpose and stakeholders (including validation approach)
2. **Use subagents for component discovery and flow analysis (parallel)**
3. Document architecture with Mermaid/ASCII diagrams
4. **Parallel validation** - Assumption validation and risk analysis run concurrently
5. Present design when confidence reaches HIGH (80+)

## Subagent Model Selection

| Task Type               | Model  | Rationale                             |
| ----------------------- | ------ | ------------------------------------- |
| File search (Glob/Grep) | Haiku  | Fast, cheap, simple                   |
| Pattern triage          | Haiku  | Flag areas for deeper analysis        |
| Pre-flight checks       | Haiku  | Simple health verification            |
| Code analysis           | Sonnet | Good comprehension, cost-effective    |
| Web research            | Sonnet | WebSearch/WebFetch for best practices |
| Targeted analysis       | Sonnet | Analyze areas flagged by triage       |
| Complexity scoring      | Sonnet | Quantify implementation effort        |
| Plan review             | Sonnet | Pattern matching, completeness check  |
| Flow/Risk escalation    | Opus   | Only for high-severity findings       |
| Plan execution          | Opus   | Autonomous implementation             |
| User interaction        | Opus   | Best judgment, nuanced responses      |

### Cost Optimization Strategy

```
Phase 3.5a: Haiku triage (4 parallel) → flags areas
Phase 3.5b: Sonnet analysis (2-4 conditional) → analyzes flagged areas
Phase 3.5c: Opus escalation (0-2 conditional) → only high-severity
```

**Result**: ~35% cost reduction for simple features, ~15% for complex features

## Structure

```
better-primitives/
├── .claude-plugin/
│   └── plugin.json
├── commands/
│   ├── _base.md      (~120 lines) - Shared patterns and templates
│   ├── plan.md       (~640 lines) - Enhanced with execution subagent
│   ├── debug.md      (~365 lines) - Parallel hypothesis testing
│   ├── analyze.md    (~375 lines) - ISO 25010 quality categories
│   └── design.md     (~510 lines) - ATAM-style risk analysis
└── README.md
```

## Key Features

- **Confidence metrics**: Numeric scoring (0-100) with clear thresholds
- **Subagent delegation**: Cost-effective exploration with model selection
- **Parallel execution**: Multiple exploration tasks run concurrently
- **Hybrid cost model**: Haiku triage → Sonnet analysis → Opus escalation
- **Standardized questions**: Consistent JSON format for all user interactions
- **Testing strategy**: Every command asks how changes should be verified
- **Web research**: Automatic fetching of best practices and documentation
- **Execution subagent**: Autonomous plan implementation
- **Complexity scoring**: Implementation difficulty assessment
- **Pre-flight checks**: Repository health validation
- **Context optimization**: Main thread never reads files directly
- **ISO 25010 categories**: Standard quality characteristics for analysis
- **Impact/Effort matrix**: Prioritized findings
- **ATAM-style risks**: Architectural risk analysis
- **ADR-style trade-offs**: Decision documentation with rationale
- **Escape hatches**: Early presentation when user requests

## Shared Patterns (\_base.md)

The `_base.md` file contains reusable patterns referenced by all commands:

- **Confidence Score Levels**: Standard INITIAL → DEVELOPING → SOLID → HIGH → READY scale
- **Model Enforcement Principles**: When to use Haiku vs Sonnet vs Opus
- **Standard Checkpoint Pattern**: How to display and iterate on confidence scores
- **Standard AskUserQuestion Format**: JSON structure for user questions
- **Anti-Patterns**: Universal don'ts and dos
- **Escape Hatch Pattern**: How to handle early presentation requests
- **Testing Strategy Question**: Standard question about verification
- **Unresolved Questions Section**: Template for documenting gaps

## License

MIT
