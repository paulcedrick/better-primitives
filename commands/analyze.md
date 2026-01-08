---
description: Start thorough analysis for improvements with subagent-powered exploration. Uses iterative confidence metrics and ISO 25010 quality categories.
---

# Analysis Mode

You are now in analysis mode. Your goal is to reach **HIGH confidence (80+)** in your recommendations before presenting final findings.

## Core Principle

**Analyze iteratively. Delegate exploration. Quantify impact. Confirm priorities.**

## Confidence Score

Calculate confidence using this formula:

```
Score = Goals(20%) + Exploration(20%) + Opportunities(15%) + Priorities(15%) + Trade-offs(15%) + Alignment(15%)
```

| Level      | Score | Description                    |
| ---------- | ----- | ------------------------------ |
| INITIAL    | 0-24  | Gathering information          |
| DEVELOPING | 25-49 | Some understanding, gaps exist |
| SOLID      | 50-74 | Good understanding, validating |
| HIGH       | 75-89 | Ready to present findings      |
| READY      | 90+   | Complete confidence            |

**Target:** Reach HIGH (80+) before presenting findings. Display score after each step.

## Analysis Process

### Phase 1: Goal Understanding (~15/100)

Ask clarifying questions using AskUserQuestion:

- What area should be improved?
- Why now? What motivated this?
- What does success look like?
- What constraints exist?

### Phase 2: Code Exploration (~40/100)

**Use the Walkthrough Protocol first:**

```
Before analyzing, let me walk through what this code does:
1. [Purpose of the code]
2. [Key flow]
3. [Current patterns]

Understanding established. Now I can identify improvements.
```

**Delegate exploration to subagents:**

```
Task (Explore, model=sonnet):
"Analyze [target area] for:
1. Code patterns used
2. Potential improvement opportunities
3. Dependencies and affected areas

Return structured summary with file paths and observations."
```

**Launch parallel subagents** for different aspects:

- Performance patterns (N+1 queries, sync operations)
- Maintainability issues (large classes, duplication)
- Security concerns (input validation, auth)

### Phase 3: Findings with Impact/Effort (~60/100)

Present findings with prioritization:

| Finding | Impact | Effort | Priority | Location    |
| ------- | ------ | ------ | -------- | ----------- |
| [issue] | 1-4    | 1-4    | sum      | `file:line` |

**Impact Scale:**

- 4 = Critical (performance, security, core functionality)
- 3 = Important (maintainability, future issues)
- 2 = Moderate (nice improvement)
- 1 = Minor (cosmetic)

**Effort Scale:**

- 4 = Low (<1 hour)
- 3 = Medium (1-4 hours)
- 2 = High (day+ work)
- 1 = Very High (multi-day)

**Priority = Impact + Effort** (7-8: Do first, 5-6: Plan soon, 3-4: Consider, 1-2: Defer)

Ask user about priorities using AskUserQuestion.

### Phase 4: Validation (~80/100)

Launch subagent to validate findings:

```
Task (Explore, model=sonnet):
"Validate these findings in [area]:
[list findings]

Check if:
1. Any related issues were missed
2. Findings align with codebase patterns
3. Proposed changes have side effects"
```

Present any new discoveries. Loop back if significant.

### Phase 5: Final Presentation (~85/100)

When confidence >= 80%, present:

```markdown
## Analysis Complete

### Confidence: [score]/100 (HIGH)

### Summary

[1-2 sentences on what was analyzed and key findings]

### Do First (Priority 7-8)

| #   | Finding | Category | Impact | Effort | Location |
| --- | ------- | -------- | ------ | ------ | -------- |

### Plan for Soon (Priority 5-6)

| #   | Finding | Category | Impact | Effort | Location |
| --- | ------- | -------- | ------ | ------ | -------- |

### Deferred

| #   | Finding | Reason |
| --- | ------- | ------ |

### Trade-offs

- [Change X]: [benefit] vs [cost]
```

Ask if user wants implementation plan.

## Quality Categories (ISO 25010)

Group findings by these characteristics:

| Category            | Focus                           |
| ------------------- | ------------------------------- |
| **Performance**     | Speed, resources, capacity      |
| **Reliability**     | Fault tolerance, recoverability |
| **Security**        | Confidentiality, integrity      |
| **Maintainability** | Modularity, testability         |
| **Compatibility**   | Interoperability                |

## Common Patterns to Find

| Pattern       | Symptoms                          | Impact    |
| ------------- | --------------------------------- | --------- |
| N+1 Query     | DB calls in loops                 | Critical  |
| God Class     | >500 lines, many responsibilities | Important |
| Feature Envy  | Method uses other class's data    | Important |
| Dead Code     | Unused imports/functions          | Minor     |
| Magic Numbers | Hard-coded values                 | Moderate  |
| Missing Types | `any` types, no validation        | Moderate  |

## Subagent Usage Summary

| Phase | Task               | Subagent | Model  |
| ----- | ------------------ | -------- | ------ |
| 2     | Pattern search     | Explore  | haiku  |
| 2     | Code analysis      | Explore  | sonnet |
| 4     | Finding validation | Explore  | sonnet |
| 1,5   | User interaction   | (main)   | opus   |

## Factor Scoring Guide

| Factor        | Low              | Medium                    | High                |
| ------------- | ---------------- | ------------------------- | ------------------- |
| Goals         | Vague area       | Core goal understood      | Explicit, confirmed |
| Exploration   | No code read     | Key files examined        | All areas mapped    |
| Opportunities | 1-2 obvious      | Several identified        | Comprehensive list  |
| Priorities    | Not discussed    | User indicated preference | Explicit ranking    |
| Trade-offs    | Not considered   | Main trade-offs noted     | All discussed       |
| Alignment     | No confirmations | Basic confirmed           | Direction confirmed |

## Minimum Thresholds for HIGH

- Goals >= 70%
- Exploration >= 60%
- Opportunities >= 50%
- Priorities >= 50%
- Trade-offs >= 40%
- Alignment >= 50%

## Anti-Patterns

**Don't:**

- Skip the Walkthrough Protocol
- Present findings without priorities
- Propose changes without trade-offs
- Ignore user's constraints

**Do:**

- Walk through code before analyzing
- Delegate exploration to subagents
- Score every finding (Impact/Effort)
- Confirm priorities with user
- Offer implementation plan

## Escape Hatch

If user wants findings early:

```
You: Current confidence is [X]/100. I can present now, but note:
- [trade-offs not discussed]
- [validation incomplete]

[Present with "Preliminary" label on unvalidated findings]
```
