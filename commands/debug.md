---
description: Start thorough debugging investigation. Uses iterative questioning to deeply understand and diagnose technical problems.
---

# Debug Mode

You are now in debug investigation mode. Your goal is to **thoroughly investigate and diagnose** the problem through iterative analysis and frequent questioning.

## Core Principle

**Investigate deeply. Confirm constantly. Never assume.**

You must ask questions after EVERY investigation step. Do not stop until you have HIGH confidence (75+) in the root cause.

## The Rubber Duck Protocol

Before forming hypotheses, explain the suspect code aloud. This forces you to slow down and articulate your understanding. Bugs often hide in the gap between "what you think the code does" and "what it actually does."

Use phrases like:

- "Let me walk through what this code does..."
- "Following the execution path..."
- "I expected X at this point, but I see Y..."

## Confidence Metrics (Summary)

Calculate confidence using this weighted formula:

```
Score = Evidence(25%) + Hypotheses(20%) + Confirmations(15%) + CodePath(12%) + Symptoms(10%) + Specificity(10%) + Fix(8%)
```

| Level          | Score  | Description                          |
| -------------- | ------ | ------------------------------------ |
| **CRITICAL**   | 0-24   | Initial phase, gathering information |
| **LOW**        | 25-49  | Partial evidence, hypotheses forming |
| **MEDIUM**     | 50-74  | Leading hypothesis with evidence     |
| **HIGH**       | 75-89  | Strong diagnosis, ready to conclude  |
| **CONCLUSIVE** | 90-100 | Definitive diagnosis with full proof |

Display the full metrics table at **every investigation step**.

## Investigation Phases

### Phase 1: Symptom Collection (~8/100 CRITICAL)

Gather complete information about the problem:

- What exactly is happening? What error/behavior do you see?
- How do you reproduce this issue?
- When did it start? What changed recently?
- Which environment? (dev, staging, prod)

### Phase 1.5: Reproduction (Optional but Recommended)

Attempt to reproduce the bug before forming hypotheses:

- Reproduced: Evidence Found +10%, Symptoms Explained +15%
- Not reproduced: Evidence Found capped at 60%, note as intermittent

### Phase 2: Hypothesis Formation (~28/100 LOW)

Form multiple hypotheses based on symptoms. Present them with a table:

| Hypothesis | Status  | Evidence           |
| ---------- | ------- | ------------------ |
| [H1]       | Testing | [initial evidence] |
| [H2]       | Testing | [none yet]         |
| [H3]       | Testing | [none yet]         |

Ask user which seems most likely based on their knowledge.

### Phase 3: Code Investigation (~54/100 MEDIUM)

**For each hypothesis, design an experiment before investigating:**

```markdown
### Experiment for Hypothesis: [H1]

**Prediction:** If [H1] is the cause, then [action] should produce [expected result].
**Test:** [command, code change, or observation]
**Expected if true:** [result]
**Expected if false:** [different result]
```

Search code systematically. After EACH search or file read:

1. Present what you found in structured format
2. Explain what it tells you about the problem
3. Ask 2-3 confirmation questions before proceeding

### Phase 4: Root Cause Identification (~82/100 HIGH)

Only conclude when you have HIGH confidence (75+). Present:

- Root cause explanation
- Evidence (file paths, code snippets)
- Recommended fix

Ask user to confirm before proposing implementation.

### Phase 5: Fix Verification (~92/100 CONCLUSIVE)

After implementing a fix, verify:

- Original bug no longer reproduces
- Existing tests still pass
- No new failures introduced
- Related functionality still works

**Only mark investigation complete after verification passes.**

## Tool Selection

| Tool                  | Use When                               |
| --------------------- | -------------------------------------- |
| **Grep**              | Searching for error messages, patterns |
| **Glob**              | Finding files by pattern               |
| **Read**              | Understanding code context             |
| **LSP incomingCalls** | Tracing call hierarchy                 |
| **Bash (tests)**      | Reproducing bug, validating fix        |

## Special Bug Types

**Heisenbug Warning:** If bug disappears when adding console.log or in debugger, avoid intrusive debugging. Use static analysis first.

**Race Conditions:** Look for shared state, missing locks, TOCTTOU patterns. Add artificial delays to exaggerate the race.

## Common Bug Patterns

Reference the **thorough-debugging skill** for detailed patterns including:

- Null/Undefined Reference
- Race Condition / Timing Bug
- Off-by-One Error
- Async/Promise Bug
- State Management Bug (React/Vue)
- Memory Leak
- Type Mismatch
- Build/Compile Error
- Flaky Test

## Minimum Thresholds for HIGH

- Evidence Found >= 60%
- Hypotheses Eliminated >= 50%
- User Confirmations >= 40%
- Symptoms Explained >= 70%

## Plan Mode Behavior

In plan mode, maximum confidence is ~85/100. You can:

- Search code (Glob, Grep)
- Read files
- Analyze patterns
- Form hypotheses

You cannot:

- Run tests or scripts
- Execute diagnostic commands
- Check runtime state

Note what execution would enable and suggest exiting plan mode when needed.

## Arguments

If the user provides a problem description with the command:

```
/debug The API returns 500 errors intermittently
```

Use this as your starting point, but still ask clarifying questions in Phase 1.

## Anti-Patterns

**Don't:**

- Jump to conclusions without evidence
- Propose fixes before understanding root cause
- Skip asking confirmation questions
- Add logging that changes timing for race conditions
- Skip verification after implementing a fix

**Do:**

- Design experiments for each hypothesis
- Use the Rubber Duck Protocol
- Verify fixes resolve the issue

Remember: **A thorough diagnosis prevents wasted effort on wrong fixes.**
