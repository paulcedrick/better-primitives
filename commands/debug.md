---
description: Start thorough debugging with subagent-powered investigation. Uses iterative confidence metrics and parallel hypothesis testing to diagnose issues.
---

# Debug Mode

You are now in debug investigation mode. Your goal is to reach **HIGH confidence (75+)** in the root cause before presenting a diagnosis.

> **Reference:** See `_base.md` for shared patterns (confidence levels, model enforcement, checkpoint format).

## Core Principle

**Investigate iteratively. Delegate searches. Test hypotheses. Confirm constantly.**

## Confidence Score

```
Score = Evidence(25%) + Hypotheses(20%) + Confirmations(15%) + CodePath(12%) + Symptoms(10%) + Specificity(10%) + Fix(8%)
```

| Level      | Score | Description                        |
| ---------- | ----- | ---------------------------------- |
| CRITICAL   | 0-24  | Initial phase, gathering info      |
| LOW        | 25-49 | Partial evidence, forming theories |
| MEDIUM     | 50-74 | Leading hypothesis emerging        |
| HIGH       | 75-89 | Strong diagnosis, ready to present |
| CONCLUSIVE | 90+   | Definitive with full proof         |

**Target:** Reach HIGH (75+) before presenting diagnosis. Display score after each phase.

## Model Enforcement (REQUIRED)

| Task Type            | Model      | Subagent        | Constraint                              |
| -------------------- | ---------- | --------------- | --------------------------------------- |
| Error pattern search | **haiku**  | Explore         | MUST use - fast, cheap                  |
| Code analysis        | **sonnet** | Explore         | MUST use - needs comprehension          |
| Call hierarchy trace | **sonnet** | Explore         | MUST use - requires reasoning           |
| Hypothesis testing   | **opus**   | general-purpose | MUST use - complex multi-step deduction |
| User interaction     | **opus**   | (main)          | MUST NOT spawn as subagent              |

**Negative Constraints:**

- **Haiku** MUST NOT: analyze code logic, test hypotheses, trace complex flows
- **Sonnet** MUST NOT: be used for simple pattern searches (use haiku), test complex hypotheses (use opus)
- **Opus**: Use for hypothesis testing (complex deduction) and main thread only

---

## Debug Process

### Phase 1: Symptom Collection (~8/100)

Gather information using AskUserQuestion:

```json
{
  "questions": [
    {
      "question": "What error or unexpected behavior are you seeing?",
      "header": "Symptom",
      "options": [
        {
          "label": "Error message",
          "description": "Specific error text or stack trace"
        },
        {
          "label": "Wrong output",
          "description": "Code runs but produces incorrect results"
        },
        {
          "label": "Performance issue",
          "description": "Slow response or high resource usage"
        },
        {
          "label": "Intermittent failure",
          "description": "Works sometimes, fails other times"
        }
      ],
      "multiSelect": false
    },
    {
      "question": "How do you reproduce this issue?",
      "header": "Reproduce",
      "options": [
        {
          "label": "Always happens",
          "description": "100% reproducible with specific steps"
        },
        {
          "label": "Sometimes happens",
          "description": "Intermittent, ~50% of the time"
        },
        {
          "label": "Rarely happens",
          "description": "Hard to reproduce, <10% of attempts"
        },
        {
          "label": "Can't reproduce",
          "description": "Happened once, haven't seen it again"
        }
      ],
      "multiSelect": false
    },
    {
      "question": "When did this start happening?",
      "header": "Timeline",
      "options": [
        {
          "label": "After recent change",
          "description": "Started after a specific commit or deploy"
        },
        { "label": "Gradually appeared", "description": "Got worse over time" },
        {
          "label": "Always been there",
          "description": "Existed since the feature was built"
        },
        { "label": "Unknown", "description": "Not sure when it started" }
      ],
      "multiSelect": false
    },
    {
      "question": "How should the fix be verified?",
      "header": "Testing",
      "options": [
        {
          "label": "Existing tests",
          "description": "Run existing test suite to verify fix"
        },
        {
          "label": "New regression test",
          "description": "Write a test that catches this bug"
        },
        {
          "label": "Manual verification",
          "description": "I'll verify manually that it's fixed"
        }
      ],
      "multiSelect": false
    }
  ]
}
```

**Iterate if needed:**

If Symptoms score < 70%:

1. Identify gap: "I need more details about [specific aspect]"
2. Ask targeted follow-up about reproduction steps or error details
3. Proceed when Symptoms >= 70%

**Checkpoint:** Display confidence score. Proceed when Symptoms >= 70%.

### Phase 2: Hypothesis Formation (~28/100)

Based on symptoms, form hypotheses and present:

```markdown
### Hypotheses

| Hypothesis | Status  | Evidence           |
| ---------- | ------- | ------------------ |
| [H1]       | Testing | [initial evidence] |
| [H2]       | Testing | [none yet]         |
| [H3]       | Testing | [none yet]         |
```

Ask which seems most likely:

```json
{
  "questions": [
    {
      "question": "Based on your knowledge of the codebase, which hypothesis seems most likely?",
      "header": "Hypothesis",
      "options": [
        { "label": "H1: [hypothesis]", "description": "[brief reasoning]" },
        { "label": "H2: [hypothesis]", "description": "[brief reasoning]" },
        { "label": "H3: [hypothesis]", "description": "[brief reasoning]" },
        {
          "label": "None of these",
          "description": "I think it's something else"
        }
      ],
      "multiSelect": false
    }
  ]
}
```

**Iterate if needed:**

If Hypotheses score < 50% or user suggests different direction:

1. Form new hypotheses based on user feedback
2. Re-present updated hypothesis table
3. Proceed when Hypotheses >= 50%

**Checkpoint:** Display confidence score. Proceed when Hypotheses >= 50%.

### Phase 3: Parallel Investigation (~55/100)

**Delegate code searches to subagents (MUST follow Model Enforcement table):**

Use the Task tool to launch **parallel** exploration:

```
# Launch these in parallel (single message, multiple Task calls):

# Pattern search - MUST use haiku
Task (Explore, model=haiku):
"Search for files containing [error message or pattern].
Return: file paths and matching lines."

# Code analysis - MUST use sonnet
Task (Explore, model=sonnet):
"Analyze [suspect file] for [hypothesis condition].
Return: relevant code sections and observations."

# Call trace - MUST use sonnet
Task (Explore, model=sonnet):
"Trace call hierarchy for [function name].
Return: entry points, callers, and data flow."
```

**After each subagent returns:**

1. Present findings in structured format
2. Update hypothesis status (Leading/Ruled out)
3. Ask 2-3 confirmation questions

**Iterate if needed:**

If Evidence score < 60% or no leading hypothesis emerges:

1. Launch additional targeted subagents
2. Test alternative hypotheses
3. Ask user for more context about specific behaviors
4. Proceed when Evidence >= 60% AND one hypothesis is leading

**Checkpoint:** Display confidence score. Proceed when Evidence >= 60%.

### Phase 4: Root Cause Identification (~82/100)

When confidence >= 75%, present:

```markdown
## Diagnosis

### Confidence: [score]/100 (HIGH)

### Root Cause

[Explanation of what's causing the issue]

### Evidence

- File: `path/to/file.ts:line`
- Code: [relevant snippet]
- Observation: [what this tells us]

### Recommended Fix

[Specific fix with code changes]

### Testing Strategy

[How to verify the fix works and prevent regression]

### Unresolved Questions

- [Behavior that couldn't be fully explained]
- [Edge case not yet tested]
- [Assumption about root cause that needs verification]

_If these affect the fix, address them before implementing._
```

Ask user to confirm before implementing:

```json
{
  "questions": [
    {
      "question": "Ready to implement this fix?",
      "header": "Proceed",
      "options": [
        { "label": "Yes, implement", "description": "Apply the fix now" },
        {
          "label": "Investigate more",
          "description": "I have doubts, dig deeper"
        },
        {
          "label": "I'll fix it",
          "description": "I understand the issue, I'll implement myself"
        }
      ],
      "multiSelect": false
    }
  ]
}
```

### Phase 5: Fix Verification (~92/100)

After implementing:

- Original bug no longer reproduces
- Existing tests still pass
- No new failures introduced

---

## Hypothesis Testing with Subagents

For each hypothesis, design an experiment:

```markdown
### Experiment: [Hypothesis]

**Prediction:** If [H] is true, then [action] produces [result]
**Test:** [what to search/check]
**Expected if true:** [result]
**Expected if false:** [different result]
```

Delegate the test to a subagent (MUST use opus for complex deduction):

```
# Hypothesis testing - MUST use opus + general-purpose
Task (general-purpose, model=opus):
"Test hypothesis: [H]. Check if [condition] exists in [location].
Return: evidence supporting or refuting the hypothesis."
```

---

## Special Bug Types

### Heisenbug (disappears when observed)

- Avoid console.log that changes timing
- Use static analysis via subagents first
- Look for race conditions

### Race Condition

- Look for shared state access
- Check for missing locks/synchronization
- Launch subagent to find TOCTTOU patterns

### Intermittent Failure

- Note reproduction rate
- Check for timing dependencies
- Search for flaky test patterns

---

## Factor Scoring Guide

| Factor        | Low (0-30%)                 | Medium (31-70%)                           | High (71-100%)                                 |
| ------------- | --------------------------- | ----------------------------------------- | ---------------------------------------------- |
| Evidence      | 0 relevant files found      | 1-3 relevant files AND pattern identified | 4+ files AND exact line numbers with context   |
| Hypotheses    | 3+ hypotheses, 0 ruled out  | 1-2 hypotheses ruled out                  | Single leading hypothesis with strong evidence |
| Confirmations | 0 user confirmations        | User confirmed symptoms only              | User confirmed symptoms AND diagnosis          |
| CodePath      | Entry point identified only | 50% of call chain traced                  | Full path from trigger to bug location         |
| Symptoms      | 0 symptoms explained        | Primary symptom explained                 | All reported symptoms explained                |
| Specificity   | "Somewhere in module X"     | "In file X, function Y"                   | "Line X in file Y, variable Z causes [issue]"  |
| Fix           | "Need to investigate more"  | Approach clear, details fuzzy             | Exact code changes with before/after           |

**How to calculate score:**

1. Rate each factor using the criteria above (0-100%)
2. Apply weights: Evidence(25%) + Hypotheses(20%) + Confirmations(15%) + CodePath(12%) + Symptoms(10%) + Specificity(10%) + Fix(8%)
3. Sum for total confidence score

## Minimum Thresholds for HIGH

- Evidence >= 60%
- Hypotheses Eliminated >= 50%
- Confirmations >= 40%
- Symptoms Explained >= 70%

---

## Anti-Patterns

**Don't:**

- Jump to conclusions without evidence
- Propose fixes before understanding root cause
- Skip asking confirmation questions
- Add logging that changes timing (for race conditions)

**Do:**

- Delegate searches to subagents
- Run hypothesis tests in parallel
- Explain code aloud (Rubber Duck Protocol)
- Verify fixes resolve the issue

## Escape Hatch

If user wants diagnosis early:

```
Current confidence is [X]/100. I can present now, but note:
- [Gap 1: hypothesis not fully tested]
- [Gap 2: evidence gap]

**Proceeding with preliminary diagnosis...**

[Present with "PRELIMINARY" label]
```
