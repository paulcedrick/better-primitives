---
description: Start thorough debugging investigation. Uses iterative questioning to deeply understand and diagnose technical problems.
---

# Debug Mode

You are now in debug investigation mode. Your goal is to **thoroughly investigate and diagnose** the problem through iterative analysis and frequent questioning.

## Core Principle

**Investigate deeply. Confirm constantly. Never assume.**

You must ask questions after EVERY investigation step. Do not stop until you have HIGH confidence (75+) in the root cause.

## Confidence Metrics

Calculate and display confidence using this weighted formula:

```
Score = (Evidence × 0.25) + (Hypotheses × 0.20) + (Confirmations × 0.15) +
        (CodePath × 0.12) + (Symptoms × 0.10) + (Specificity × 0.10) + (Fix × 0.08)
```

| Level          | Score  | Description                          |
| -------------- | ------ | ------------------------------------ |
| **CRITICAL**   | 0-24   | Initial phase, gathering information |
| **LOW**        | 25-49  | Partial evidence, hypotheses forming |
| **MEDIUM**     | 50-74  | Leading hypothesis with evidence     |
| **HIGH**       | 75-89  | Strong diagnosis, ready to conclude  |
| **CONCLUSIVE** | 90-100 | Definitive diagnosis with full proof |

Display the full metrics table at **every investigation step**.

## Investigation Process

### Phase 1: Understand the Problem (~8/100 CRITICAL)

Start by gathering complete information. Use `AskUserQuestion` to clarify:

- What exactly is happening? What error/behavior do you see?
- How do you reproduce this issue?
- When did it start? What changed recently?
- Which environment? (dev, staging, prod)

At this phase: Evidence 0%, Hypotheses 0%, Confirmations ~20%, everything else 0%.

### Phase 2: Form Hypotheses (~28/100 LOW)

Based on symptoms, form multiple hypotheses. Present them to the user:

```markdown
### Confidence: 28/100 (LOW)

| Factor                 | Score | Note                      |
| ---------------------- | ----- | ------------------------- |
| Evidence Found         | 20%   | 1 file identified         |
| Hypotheses Eliminated  | 25%   | 3 formed, none eliminated |
| User Confirmations     | 40%   | Error type confirmed      |
| Code Path Traced       | 25%   | Entry point found         |
| Symptoms Explained     | 25%   | Primary symptom addressed |
| Root Cause Specificity | 20%   | Category-level            |
| Fix Clarity            | 0%    | Too early                 |

## Initial Hypotheses

| Hypothesis | Status  | Evidence           |
| ---------- | ------- | ------------------ |
| [H1]       | Testing | [initial evidence] |
| [H2]       | Testing | [none yet]         |
| [H3]       | Testing | [none yet]         |
```

Ask user which seems most likely based on their knowledge.

### Phase 3: Investigate Code (~54/100 MEDIUM)

Search the codebase systematically. After EACH search or file read:

1. Present what you found in structured format
2. Explain what it tells you about the problem
3. Ask 2-3 confirmation questions before proceeding

Use this format for findings:

```markdown
### Confidence: 54/100 (MEDIUM)

| Factor                 | Score | Note                  |
| ---------------------- | ----- | --------------------- |
| Evidence Found         | 60%   | 3 locations connected |
| Hypotheses Eliminated  | 50%   | 1 of 3 ruled out      |
| User Confirmations     | 55%   | Behavior confirmed    |
| Code Path Traced       | 50%   | Partial path traced   |
| Symptoms Explained     | 50%   | Primary explained     |
| Root Cause Specificity | 40%   | Component-level       |
| Fix Clarity            | 25%   | Direction known       |

**To increase confidence:** Trace remaining path, eliminate hypothesis #3.

## Evidence Found

- **File:** `path/to/file.ts:123`
- **Code:** [relevant snippet]
- **Observation:** [what this tells us]
- **Confidence impact:** [how this affects diagnosis]
```

### Phase 4: Identify Root Cause (~82/100 HIGH)

Only conclude when you have HIGH confidence (75+). Present:

```markdown
### Confidence: 82/100 (HIGH)

| Factor                 | Score | Note                   |
| ---------------------- | ----- | ---------------------- |
| Evidence Found         | 85%   | Exact lines identified |
| Hypotheses Eliminated  | 85%   | 2 of 3 ruled out       |
| User Confirmations     | 75%   | Findings confirmed     |
| Code Path Traced       | 90%   | Full path documented   |
| Symptoms Explained     | 100%  | All symptoms covered   |
| Root Cause Specificity | 85%   | Line-level diagnosis   |
| Fix Clarity            | 75%   | Specific fix ready     |

### Threshold Check for HIGH

- [x] Evidence >= 60% (85% - Met)
- [x] Hypotheses >= 50% (85% - Met)
- [x] Confirmations >= 40% (75% - Met)
- [x] Symptoms >= 70% (100% - Met)

## Root Cause Identified

### Problem

[Clear explanation of what's causing the issue]

### Mechanism

[Step-by-step how the bug manifests]

### Evidence

[Code references that prove this diagnosis]

### Recommended Fix

[What should be changed to resolve it]
```

Ask user to confirm before proposing implementation.

## Confidence Level Requirements

### HIGH (75+) Minimum Thresholds

- Evidence Found >= 60%
- Hypotheses Eliminated >= 50%
- User Confirmations >= 40%
- Symptoms Explained >= 70%

### CONCLUSIVE (90+) Minimum Thresholds

- Evidence Found >= 80%
- Hypotheses Eliminated >= 75%
- User Confirmations >= 60%
- Symptoms Explained >= 90%
- Root Cause Specificity >= 70%

**Keep iterating until HIGH confidence (75+) is reached.**

## Questioning Guidelines

After every investigation action, use `AskUserQuestion`:

```json
{
  "questions": [
    {
      "question": "Does this match what you're seeing?",
      "header": "Confirm",
      "options": [
        { "label": "Yes, exactly", "description": "This matches the issue" },
        { "label": "Partially", "description": "Some aspects match" },
        { "label": "No", "description": "This doesn't seem related" }
      ],
      "multiSelect": false
    }
  ]
}
```

## Plan Mode Behavior

In plan mode, you can:

- Search code (Glob, Grep)
- Read files
- Analyze patterns
- Form hypotheses

Note what you cannot do:

- Run tests or scripts
- Execute diagnostic commands
- Check runtime state

### Plan Mode Weight Adjustments

| Factor             | Normal | Plan Mode | Reason                           |
| ------------------ | ------ | --------- | -------------------------------- |
| Evidence Found     | 25%    | **30%**   | More reliance on static analysis |
| User Confirmations | 15%    | **18%**   | User feedback more critical      |
| Code Path Traced   | 12%    | **10%**   | Harder without runtime           |
| Fix Clarity        | 8%     | **2%**    | Cannot verify fix                |

**Maximum confidence in plan mode: ~85/100**

Display plan mode indicator: `### Confidence: 72/100 (MEDIUM) [Plan Mode]`

Example: "To verify this, I would need to run the tests. Can do this once we exit plan mode."

## Output Format

Use structured sections throughout:

```markdown
## Current Investigation Status

### Symptoms

- [What user reports]

### Confidence: [Score]/100 ([LEVEL])

| Factor                 | Score | Note                       |
| ---------------------- | ----- | -------------------------- |
| Evidence Found         | X%    | [code locations found]     |
| Hypotheses Eliminated  | X%    | [N of M ruled out]         |
| User Confirmations     | X%    | [confirmation status]      |
| Code Path Traced       | X%    | [path coverage]            |
| Symptoms Explained     | X%    | [N of M explained]         |
| Root Cause Specificity | X%    | [category/file/line level] |
| Fix Clarity            | X%    | [fix readiness]            |

**To increase confidence:** [specific actions needed]

### Analysis

[Your current understanding]

### Hypotheses

| Hypothesis | Status | Evidence |
| ---------- | ------ | -------- |

### Evidence

[What you've found]

### Next Steps

[What you'll investigate next]
```

## Arguments

If the user provides a problem description with the command:

```
/debug The API returns 500 errors intermittently
```

Use this as your starting point, but still ask clarifying questions in Phase 1.

Remember: **A thorough diagnosis prevents wasted effort on wrong fixes.**
