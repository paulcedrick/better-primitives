---
description: Start enhanced planning with thorough questioning and subagent exploration. Uses iterative confidence metrics to deeply understand requirements before planning implementation.
---

# Enhanced Planning Mode

You are now in enhanced planning mode. Your goal is to achieve **high confidence** (80+) in your understanding before presenting an implementation plan.

## Core Principle

**Iterate until confident. Delegate exploration. Synthesize findings. Confirm with user.**

## Confidence Score

Calculate confidence using this formula:

```
Score = Intent(25%) + Context(20%) + Requirements(15%) + Solution(20%) + Risk(10%) + Alignment(10%)
```

| Level      | Score | Description                    |
| ---------- | ----- | ------------------------------ |
| INITIAL    | 0-24  | Gathering basic information    |
| DEVELOPING | 25-49 | Some understanding, gaps exist |
| SOLID      | 50-74 | Good understanding, validating |
| HIGH       | 75-89 | Ready to present plan          |
| READY      | 90+   | Complete confidence            |

**Target:** Reach HIGH (80+) before presenting the plan. Display score after each step.

## Model Enforcement (REQUIRED)

You MUST follow these model restrictions for ALL Task tool invocations:

| Task Type          | Model      | Subagent        | Constraint                                            |
| ------------------ | ---------- | --------------- | ----------------------------------------------------- |
| File search        | **haiku**  | Explore         | MUST use - fast, cheap                                |
| Code analysis      | **sonnet** | Explore         | MUST use - needs comprehension                        |
| Deep investigation | **opus**   | general-purpose | MUST use - architectural decisions, complex reasoning |
| User interaction   | **opus**   | (main)          | MUST NOT spawn as subagent                            |

**Negative Constraints:**

- **Haiku** MUST NOT: analyze code patterns, investigate dependencies, reason about architecture
- **Sonnet** MUST NOT: be used for simple file searches (use haiku), deep investigation (use opus), present final plans
- **Opus**: Use for deep investigation (architectural decisions) and main thread only

---

## Planning Process

### Phase 1: Intent Clarification (~15/100)

Ask clarifying questions using AskUserQuestion:

- What exactly needs to be built?
- What problem does this solve?
- What does success look like?
- What constraints exist?

### Phase 2: Codebase Exploration (~45/100)

**Delegate exploration to subagents (MUST follow Model Enforcement table above):**

```
# Launch in parallel (single message, multiple Task calls):

# File search - MUST use haiku (DO NOT use sonnet - unnecessary cost)
Task 1 (Explore, model=haiku):
"Search for files related to [feature area].
Return: file paths and brief descriptions."

# Code analysis - MUST use sonnet (DO NOT use haiku - needs comprehension)
Task 2 (Explore, model=sonnet):
"Analyze the codebase for:
1. Existing patterns and conventions
2. Dependencies and affected areas

Return a structured summary with:
- Key files found (with paths)
- Patterns observed
- Potential integration points"
```

**Launch multiple exploration subagents in parallel** when searching different areas (model=haiku for file searches, model=sonnet for analysis).

### Phase 3: Solution Validation (~65/100)

Based on exploration results:

1. Identify potential approaches
2. Evaluate against existing patterns
3. Ask user about trade-offs using AskUserQuestion

Example:

```json
{
  "questions": [
    {
      "question": "Which approach should we use?",
      "header": "Approach",
      "options": [
        { "label": "Option A", "description": "[trade-offs]" },
        { "label": "Option B", "description": "[trade-offs]" }
      ],
      "multiSelect": false
    }
  ]
}
```

### Phase 4: Plan Presentation (~82/100)

When confidence >= 80%, present:

```markdown
## Implementation Plan

### Confidence: [score]/100 (HIGH)

### Summary

[1-2 sentences on what will be built]

### Steps

1. **[Step title]**
   - Files: `path/to/file`
   - Changes: [description]

### Key Decisions

| Decision | Status            | Rationale |
| -------- | ----------------- | --------- |
| [choice] | Confirmed/Assumed | [why]     |

### Risks

| Risk   | Mitigation       |
| ------ | ---------------- |
| [risk] | [how to address] |
```

Then ask for approval:

```json
{
  "questions": [
    {
      "question": "Ready to proceed with this plan?",
      "header": "Proceed?",
      "options": [
        { "label": "Yes, proceed", "description": "Start implementing" },
        { "label": "Revise plan", "description": "I have changes" },
        { "label": "More questions", "description": "Need to clarify" }
      ],
      "multiSelect": false
    }
  ]
}
```

## Factor Scoring Guide

| Factor       | Low (0-25%)      | Medium (50%)         | High (75-100%)            |
| ------------ | ---------------- | -------------------- | ------------------------- |
| Intent       | Vague request    | Core goal understood | Explicit, confirmed goals |
| Context      | No exploration   | Key files identified | All areas mapped          |
| Requirements | Scope unknown    | Scope clear          | Edge cases documented     |
| Solution     | No approach      | Approach identified  | Validated with evidence   |
| Risk         | Not considered   | Main risks noted     | Mitigations planned       |
| Alignment    | No confirmations | Basic confirmed      | Key decisions confirmed   |

## Subagent Usage Summary (REQUIRED - See Model Enforcement section)

| Phase | Task               | Subagent        | Model      | Enforcement                        |
| ----- | ------------------ | --------------- | ---------- | ---------------------------------- |
| 2     | File search        | Explore         | **haiku**  | MUST use - fast/cheap              |
| 2     | Code analysis      | Explore         | **sonnet** | MUST use - needs comprehension     |
| 3     | Deep investigation | general-purpose | **opus**   | MUST use - architectural decisions |
| 1,4   | User interaction   | (main)          | **opus**   | MUST NOT spawn as subagent         |

## Minimum Thresholds for HIGH

- Intent >= 70%
- Context >= 60%
- Requirements >= 50%
- Solution >= 60%
- Alignment >= 50%

## Anti-Patterns

**Don't:**

- Present plan before 80% confidence
- Skip exploration (delegate it instead)
- Make assumptions without asking
- Ask more than 4 questions per round

**Do:**

- Show confidence score at every step
- Delegate exploration to subagents
- Confirm key decisions with user
- Keep iterating until HIGH

## Escape Hatch

If user wants the plan early:

```
You: Current confidence is [X]/100. I can present now, but note:
- [gap 1]
- [gap 2]

[Present plan with "Assumed" status on unvalidated decisions]
```
