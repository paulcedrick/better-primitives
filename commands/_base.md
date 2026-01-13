# Shared Patterns for Better Primitives Commands

This file contains reusable patterns referenced by all commands. It is NOT a command itself.

---

## Confidence Score Levels

All commands use the same confidence level thresholds:

| Level      | Score | Description                    |
| ---------- | ----- | ------------------------------ |
| INITIAL    | 0-24  | Gathering information          |
| DEVELOPING | 25-49 | Some understanding, gaps exist |
| SOLID      | 50-74 | Good understanding, validating |
| HIGH       | 75-89 | Ready to present deliverable   |
| READY      | 90+   | Complete confidence            |

**Target:** Reach HIGH (80+) before presenting. Display score after each phase.

---

## Model Enforcement Principles

### Model Selection Criteria

| Model      | Use For                                             | Constraint                         |
| ---------- | --------------------------------------------------- | ---------------------------------- |
| **Haiku**  | File/pattern searches, triage, simple discovery     | Fast, cheap - no complex reasoning |
| **Sonnet** | Code comprehension, pattern detection, feasibility  | Good reasoning at moderate cost    |
| **Opus**   | Flow tracing, risk assessment, synthesis, execution | Quality-critical tasks only        |

### Negative Constraints

- **Haiku** MUST NOT: analyze code logic, trace flows, assess risks, make decisions
- **Sonnet** MUST NOT: be used for simple file searches (use haiku), trace complex async flows (use opus)
- **Opus** MUST NOT: be spawned as subagent for simple tasks - reserve for high-value reasoning

### Subagent Types

| Subagent        | When to Use                               |
| --------------- | ----------------------------------------- |
| Explore         | File search, code analysis, pattern match |
| general-purpose | Complex multi-step reasoning, execution   |

---

## Standard Checkpoint Pattern

After each phase, display confidence and check thresholds:

```
**Checkpoint:** Confidence is [X]/100.
- [Factor1]: [score]% ([status])
- [Factor2]: [score]% ([status])

[If below threshold]: "I need to [action] before proceeding..."
[If at threshold]: Proceeding to Phase [N+1].
```

---

## Standard Iteration Pattern

When a factor is below its minimum threshold:

```markdown
**Iterate if needed:**

If [Factor] score < [threshold]%:

1. Identify the gap: "[specific missing information]"
2. Take corrective action: [launch subagent / ask user / explore more]
3. Re-evaluate score
4. Repeat until threshold met or user requests early exit
```

---

## Factor Scoring Principles

### Measurable Criteria Structure

Each factor should have:

- **Numeric floor**: Minimum countable items (files, questions, confirmations)
- **Qualitative sufficiency**: Coverage description that's scale-independent
- **Combined criterion**: "N+ items AND [qualitative coverage]"

### Example Format

| Factor | Low (0-30%) | Medium (31-70%)              | High (71-100%)             |
| ------ | ----------- | ---------------------------- | -------------------------- |
| [Name] | < N items   | N-M items + partial coverage | M+ items AND full coverage |

---

## Standard AskUserQuestion Format

All user questions should use this JSON structure:

```json
{
  "questions": [
    {
      "question": "[Clear question ending with ?]",
      "header": "[Short label, max 12 chars]",
      "options": [
        {
          "label": "[Option name] (Recommended)",
          "description": "[What this means / trade-offs]"
        },
        {
          "label": "[Alternative]",
          "description": "[What this means]"
        }
      ],
      "multiSelect": false
    }
  ]
}
```

**Guidelines:**

- 2-4 options per question
- First option should be recommended default (add "(Recommended)" suffix)
- Descriptions explain trade-offs, not just restate the label
- Use `multiSelect: true` only when options aren't mutually exclusive

---

## Anti-Patterns (Universal)

**Don't:**

- Skip confidence checkpoints
- Present deliverables before reaching HIGH confidence
- Use expensive models for simple searches
- Ignore user's constraints or preferences
- Proceed without user confirmation at key decision points

**Do:**

- Display confidence score at every phase transition
- Delegate exploration to appropriate subagents
- Ask clarifying questions when uncertain
- Document trade-offs for significant decisions
- Offer escape hatch for early presentation

---

## Escape Hatch Pattern

When user requests early presentation:

```markdown
Current confidence is [X]/100. I can present now, but note:

- [Gap 1: what's missing or unvalidated]
- [Gap 2: risks of proceeding]

**Proceeding with preliminary [deliverable]...**

[Present with "PRELIMINARY" labels on unvalidated sections]
```

---

## Testing Strategy Question

Add to initial questions for all commands:

```json
{
  "question": "How should changes be verified?",
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
```

---

## Context Inheritance

When user has recently run another better-primitives command:

```markdown
**Context Check:** I see you recently ran /better-primitives:[previous].

Should I:

1. **Reuse context** - Use exploration data and goals from [previous]
2. **Fresh start** - Begin new exploration from scratch

[If reuse]: Inheriting: [list key context items]
```

---

## Unresolved Questions Section

Every final deliverable should include:

```markdown
### Unresolved Questions

- [Question that couldn't be answered during analysis]
- [Assumption made due to lack of information]
- [Area requiring further investigation]

_If these affect [deliverable type], address them before proceeding._
```
