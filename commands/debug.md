---
description: Start thorough debugging with subagent-powered investigation. Uses iterative confidence metrics and parallel hypothesis testing to diagnose issues.
---

# Debug Mode

You are now in debug investigation mode. Your goal is to reach **HIGH confidence (75+)** in the root cause before presenting a diagnosis.

## Core Principle

**Investigate iteratively. Delegate searches. Test hypotheses. Confirm constantly.**

## Confidence Score

Calculate confidence using this formula:

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

**Target:** Reach HIGH (75+) before presenting diagnosis. Display score after each step.

## Debug Process

### Phase 1: Symptom Collection (~8/100)

Gather information using AskUserQuestion:

- What error/behavior are you seeing?
- How do you reproduce this?
- When did it start? What changed?
- Which environment? (dev/staging/prod)

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

Ask which seems most likely based on user's knowledge.

### Phase 3: Parallel Investigation (~55/100)

**Delegate code searches to subagents:**

Use the Task tool to launch **parallel** exploration:

```
# Launch these in parallel (single message, multiple Task calls):

Task 1 (Explore, model=haiku):
"Search for files containing [error message or pattern]"

Task 2 (Explore, model=sonnet):
"Analyze [suspect file] for [hypothesis condition]"

Task 3 (Explore, model=sonnet):
"Trace call hierarchy for [function name]"
```

**After each subagent returns:**

1. Present findings in structured format
2. Update hypothesis status (Leading/Ruled out)
3. Ask 2-3 confirmation questions

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
```

Ask user to confirm before implementing.

### Phase 5: Fix Verification (~92/100)

After implementing:

- Original bug no longer reproduces
- Existing tests still pass
- No new failures introduced

## Hypothesis Testing with Subagents

For each hypothesis, design an experiment:

```markdown
### Experiment: [Hypothesis]

**Prediction:** If [H] is true, then [action] produces [result]
**Test:** [what to search/check]
**Expected if true:** [result]
**Expected if false:** [different result]
```

Delegate the test to a subagent:

```
Task (Explore, model=sonnet):
"Test hypothesis: [H]. Check if [condition] exists in [location].
Return: evidence supporting or refuting the hypothesis."
```

## Subagent Usage Summary

| Phase | Task                 | Subagent        | Model  |
| ----- | -------------------- | --------------- | ------ |
| 3     | Error pattern search | Explore         | haiku  |
| 3     | Code analysis        | Explore         | sonnet |
| 3     | Call hierarchy trace | Explore         | sonnet |
| 3     | Hypothesis testing   | general-purpose | sonnet |
| 1,4   | User interaction     | (main)          | opus   |

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

## Factor Scoring Guide

| Factor        | Low                      | Medium                  | High                    |
| ------------- | ------------------------ | ----------------------- | ----------------------- |
| Evidence      | No code found            | Relevant locations      | Exact lines identified  |
| Hypotheses    | Multiple, none ruled out | Some eliminated         | Single leading          |
| Confirmations | No questions asked       | User confirmed symptoms | Diagnosis confirmed     |
| CodePath      | Entry point only         | Partial path            | Full path traced        |
| Symptoms      | None explained           | Primary explained       | All explained           |
| Specificity   | Category-level           | File-level              | Line-level              |
| Fix           | No fix known             | Approach clear          | Exact changes specified |

## Minimum Thresholds for HIGH

- Evidence >= 60%
- Hypotheses Eliminated >= 50%
- Confirmations >= 40%
- Symptoms Explained >= 70%

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
You: Current confidence is [X]/100. I can present now, but note:
- [hypothesis not fully tested]
- [evidence gap]

[Present with "Preliminary" label]
```
