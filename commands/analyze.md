---
description: Start thorough analysis for improvements with subagent-powered exploration. Uses iterative confidence metrics and ISO 25010 quality categories.
---

# Analysis Mode

You are now in analysis mode. Your goal is to reach **HIGH confidence (80+)** in your recommendations before presenting final findings.

> **Reference:** See `_base.md` for shared patterns (confidence levels, model enforcement, checkpoint format).

## Core Principle

**Analyze iteratively. Delegate exploration. Quantify impact. Confirm priorities.**

## Confidence Score

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

**Target:** Reach HIGH (80+) before presenting findings. Display score after each phase.

## Model Enforcement (REQUIRED)

| Task Type           | Model      | Subagent | Constraint                     |
| ------------------- | ---------- | -------- | ------------------------------ |
| Pattern/file search | **haiku**  | Explore  | MUST use - fast, cheap         |
| Code analysis       | **sonnet** | Explore  | MUST use - needs comprehension |
| Finding validation  | **sonnet** | Explore  | MUST use - reasoning required  |
| User interaction    | **opus**   | (main)   | MUST NOT spawn as subagent     |

**Negative Constraints:**

- **Haiku** MUST NOT: perform complex reasoning, synthesize findings, make decisions
- **Sonnet** MUST NOT: be used for simple file searches (use haiku), present final deliverables
- **Opus** MUST NOT: be spawned as a subagent - use in main thread only

---

## Analysis Process

### Phase 1: Goal Understanding (~15/100)

Ask clarifying questions using AskUserQuestion:

```json
{
  "questions": [
    {
      "question": "What area of the codebase should be analyzed for improvements?",
      "header": "Target Area",
      "options": [
        {
          "label": "Specific module",
          "description": "Focus on a particular component or feature"
        },
        {
          "label": "Entire codebase",
          "description": "Broad analysis across all areas"
        },
        {
          "label": "Performance hotspots",
          "description": "Focus on slow or resource-heavy code"
        }
      ],
      "multiSelect": false
    },
    {
      "question": "What motivated this analysis?",
      "header": "Motivation",
      "options": [
        {
          "label": "Technical debt",
          "description": "Code quality has degraded over time"
        },
        {
          "label": "Performance issues",
          "description": "Slow response times or high resource usage"
        },
        {
          "label": "Upcoming changes",
          "description": "Need to understand before modifying"
        },
        {
          "label": "Security review",
          "description": "Identify potential vulnerabilities"
        }
      ],
      "multiSelect": true
    },
    {
      "question": "What does success look like for this analysis?",
      "header": "Success",
      "options": [
        {
          "label": "Prioritized list",
          "description": "Ranked issues with effort estimates"
        },
        {
          "label": "Quick wins",
          "description": "Focus on easy, high-impact changes"
        },
        {
          "label": "Comprehensive audit",
          "description": "Thorough documentation of all issues"
        }
      ],
      "multiSelect": false
    },
    {
      "question": "How should improvements be verified?",
      "header": "Testing",
      "options": [
        {
          "label": "Existing tests",
          "description": "Run existing test suite to verify no regressions"
        },
        {
          "label": "New tests needed",
          "description": "Write new tests for changed functionality"
        },
        {
          "label": "Manual verification",
          "description": "I'll verify manually, no automated tests needed"
        }
      ],
      "multiSelect": false
    }
  ]
}
```

**Iterate if needed:**

If Goals score < 70%:

1. Identify gap: "I need to understand [specific unclear aspect]"
2. Ask targeted follow-up question
3. Re-evaluate and proceed when Goals >= 70%

**Checkpoint:** Display confidence score. Proceed when Goals >= 70%.

### Phase 2: Code Exploration (~40/100)

**Use the Walkthrough Protocol first:**

```
Before analyzing, let me walk through what this code does:
1. [Purpose of the code]
2. [Key flow]
3. [Current patterns]

Understanding established. Now I can identify improvements.
```

**Then apply Rubber Duck Protocol:**

Explain the code aloud as if teaching someone:

- "This module handles..."
- "When a request comes in, the data flows through..."
- "The current approach works by..."

This surfaces gaps in understanding before proposing changes.

**Delegate exploration to subagents (MUST follow Model Enforcement table):**

```
# Launch in parallel (single message, multiple Task calls):

# Pattern search - MUST use haiku
Task (Explore, model=haiku):
"Search for files related to [target area].
Return: file paths and brief descriptions."

# Code analysis - MUST use sonnet
Task (Explore, model=sonnet):
"Analyze [target area] for:
1. Code patterns used
2. Potential improvement opportunities
3. Dependencies and affected areas

Return structured summary with file paths and observations."
```

**Launch parallel subagents** for different aspects (model=haiku for searches, model=sonnet for analysis):

- Performance patterns (N+1 queries, sync operations) → sonnet
- Maintainability issues (large classes, duplication) → sonnet
- Security concerns (input validation, auth) → sonnet

**Iterate if needed:**

If Exploration score < 60%:

1. Identify gap: "I haven't examined [specific area]"
2. Launch additional targeted subagents
3. Re-evaluate and proceed when Exploration >= 60%

**Checkpoint:** Display confidence score. Proceed when Exploration >= 60%.

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

Ask user about priorities:

```json
{
  "questions": [
    {
      "question": "Based on these findings, which priority level should I focus on?",
      "header": "Focus",
      "options": [
        {
          "label": "Do First (7-8)",
          "description": "High impact, reasonable effort - best ROI"
        },
        {
          "label": "All actionable (5+)",
          "description": "Include Plan Soon items as well"
        },
        {
          "label": "Quick wins only",
          "description": "High effort (4) items regardless of impact"
        }
      ],
      "multiSelect": false
    }
  ]
}
```

**Iterate if needed:**

If Priorities score < 50% or user disagrees with scoring:

1. Re-score findings with user input
2. Ask follow-up questions about specific trade-offs
3. Proceed when Priorities >= 50%

**Checkpoint:** Display confidence score. Proceed when Priorities >= 50%.

### Phase 4: Validation (~80/100)

Launch subagent to validate findings (MUST use sonnet):

```
# Validation - MUST use sonnet
Task (Explore, model=sonnet):
"Validate these findings in [area]:
[list findings]

Check if:
1. Any related issues were missed
2. Findings align with codebase patterns
3. Proposed changes have side effects"
```

Present any new discoveries and update findings table.

**Iterate if needed:**

If validation reveals significant gaps or Trade-offs score < 40%:

1. Launch targeted subagent for new findings
2. Update findings table with new discoveries
3. Re-confirm priorities with user if needed

**Checkpoint:** Display confidence score. Proceed when overall score >= 80%.

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

### Unresolved Questions

- [Question that couldn't be answered during analysis]
- [Assumption made due to lack of information]
- [Area requiring further investigation]

_If these affect implementation priority, address them before proceeding._
```

Ask if user wants implementation plan.

---

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

---

## Factor Scoring Guide

| Factor        | Low (0-30%)                 | Medium (31-70%)                          | High (71-100%)                                    |
| ------------- | --------------------------- | ---------------------------------------- | ------------------------------------------------- |
| Goals         | < 2 questions answered      | 2-3 questions answered                   | All 4 questions answered AND user confirmed scope |
| Exploration   | < 3 files examined          | 3-7 files AND primary dependencies found | 8+ files AND all integration points mapped        |
| Opportunities | 1-2 obvious issues found    | 3-5 issues with Impact/Effort scores     | 6+ issues across multiple ISO 25010 categories    |
| Priorities    | No user input on priorities | User indicated general preference        | User ranked top items AND confirmed defer list    |
| Trade-offs    | 0 trade-offs documented     | 1-2 trade-offs noted                     | Trade-off documented for each "Do First" item     |
| Alignment     | 0 confirmations from user   | 1 confirmation (goals OR priorities)     | 2+ confirmations AND final direction approved     |

**How to calculate score:**

1. Rate each factor using the criteria above (0-100%)
2. Apply weights: Goals(20%) + Exploration(20%) + Opportunities(15%) + Priorities(15%) + Trade-offs(15%) + Alignment(15%)
3. Sum for total confidence score

## Minimum Thresholds for HIGH

- Goals >= 70%
- Exploration >= 60%
- Opportunities >= 50%
- Priorities >= 50%
- Trade-offs >= 40%
- Alignment >= 50%

---

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
Current confidence is [X]/100. I can present now, but note:
- [Gap 1: what's unvalidated]
- [Gap 2: risks]

**Proceeding with preliminary analysis...**

[Present with "PRELIMINARY" labels on unvalidated findings]
```
