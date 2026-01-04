---
name: thorough-debugging
description: Enables thorough, question-driven debugging. Triggers when users report bugs, errors, or technical issues. Iteratively investigates with frequent confirmation questions until high confidence in root cause.
---

# Thorough Debugging Skill

When investigating any bug, error, or technical issue, follow this iterative, question-driven debugging approach.

## Triggering Conditions

Activate this skill when:

- User reports an error, bug, or something "not working"
- User shares error messages, stack traces, or unexpected behavior
- User describes unexpected output or behavior
- User mentions build failures, test failures, or deployment issues
- User describes performance problems or system issues
- User asks "why is this happening?" about a technical problem

## Core Principle

**Investigate iteratively. Confirm frequently. Never assume.**

After EVERY investigation step, ask 2-3 questions to confirm your findings before moving forward. Keep investigating until you reach HIGH confidence in the root cause.

## Confidence Metrics System

Confidence is calculated using a **weighted multi-factor formula** that produces a numeric score (0-100). This provides transparent, measurable progress through the investigation.

### Scoring Formula

```
ConfidenceScore = (Evidence × 0.25) + (Hypotheses × 0.20) + (Confirmations × 0.15) +
                  (CodePath × 0.12) + (Symptoms × 0.10) + (Specificity × 0.10) + (Fix × 0.08)
```

### Factor Weights

| Factor                 | Weight | Description                                             |
| ---------------------- | ------ | ------------------------------------------------------- |
| Evidence Found         | 25%    | Code locations/files supporting the diagnosis           |
| Hypotheses Eliminated  | 20%    | Alternative explanations ruled out with evidence        |
| User Confirmations     | 15%    | User-validated findings during investigation            |
| Code Path Traced       | 12%    | Execution flow from trigger to error documented         |
| Symptoms Explained     | 10%    | Percentage of reported symptoms the hypothesis explains |
| Root Cause Specificity | 10%    | How specific: generic category vs exact line/condition  |
| Fix Clarity            | 8%     | Whether a concrete, actionable fix can be proposed      |

### Confidence Levels and Thresholds

| Level          | Score  | Description                                                 |
| -------------- | ------ | ----------------------------------------------------------- |
| **CRITICAL**   | 0-24   | Initial investigation phase, gathering information          |
| **LOW**        | 25-49  | Partial evidence found, hypotheses forming                  |
| **MEDIUM**     | 50-74  | Leading hypothesis emerging with supporting evidence        |
| **HIGH**       | 75-89  | Strong evidence, alternatives eliminated, ready to diagnose |
| **CONCLUSIVE** | 90-100 | Definitive diagnosis with comprehensive evidence            |

### Minimum Requirements for HIGH (75+)

To reach HIGH confidence, these minimums must be met (otherwise capped at 74):

- Evidence Found >= 60%
- Hypotheses Eliminated >= 50% (or only 1 hypothesis remaining)
- User Confirmations >= 40%
- Symptoms Explained >= 70%

### Minimum Requirements for CONCLUSIVE (90+)

To reach CONCLUSIVE confidence, these minimums must be met (otherwise capped at 89):

- Evidence Found >= 80%
- Hypotheses Eliminated >= 75% (or single hypothesis confirmed)
- User Confirmations >= 60%
- Symptoms Explained >= 90%
- Root Cause Specificity >= 70%

## Factor Measurement Criteria

### Evidence Found (0-100%)

| Score | Criteria                                                      |
| ----- | ------------------------------------------------------------- |
| 0%    | No relevant code found yet                                    |
| 20%   | 1 potentially relevant file/location identified               |
| 40%   | 2-3 relevant code locations found, connection unclear         |
| 60%   | Multiple relevant locations with clear connection to symptoms |
| 80%   | Specific code block/lines identified as root cause location   |
| 100%  | Exact lines, conditions, and data flow fully identified       |

### Hypotheses Eliminated (0-100%)

| Score | Criteria                                                        |
| ----- | --------------------------------------------------------------- |
| 0%    | No hypotheses formed yet                                        |
| 25%   | Multiple hypotheses formed, none eliminated                     |
| 50%   | Some hypotheses ruled out with evidence                         |
| 75%   | Most alternatives eliminated, 1-2 remaining                     |
| 100%  | Single hypothesis remaining, all others ruled out with evidence |

### User Confirmations (0-100%)

| Score | Criteria                                                 |
| ----- | -------------------------------------------------------- |
| 0%    | No confirmation questions asked yet                      |
| 25%   | Questions asked, awaiting response                       |
| 50%   | User confirmed symptoms/context match investigation      |
| 75%   | User confirmed specific code/behavior findings           |
| 100%  | User explicitly confirmed diagnosis matches observations |

### Code Path Traced (0-100%)

| Score | Criteria                                                     |
| ----- | ------------------------------------------------------------ |
| 0%    | No code path analysis                                        |
| 25%   | Entry point identified                                       |
| 50%   | Partial path traced (entry to midpoint OR midpoint to error) |
| 75%   | Complete path traced with minor gaps                         |
| 100%  | Full execution path from trigger to error documented         |

### Symptoms Explained (0-100%)

| Score | Criteria                                             |
| ----- | ---------------------------------------------------- |
| 0%    | Hypothesis explains no reported symptoms             |
| 25%   | Explains 1 symptom, others unexplained               |
| 50%   | Explains primary symptom, secondary symptoms unclear |
| 75%   | Explains most symptoms, minor gaps                   |
| 100%  | All reported symptoms accounted for by diagnosis     |

**Formula:** Score = (explained symptoms / total symptoms) × 100

### Root Cause Specificity (0-100%)

| Score | Criteria                        | Example                                                    |
| ----- | ------------------------------- | ---------------------------------------------------------- |
| 0%    | No root cause identified        | -                                                          |
| 20%   | Category-level diagnosis        | "Configuration issue"                                      |
| 40%   | Component-level diagnosis       | "Problem in auth module"                                   |
| 60%   | File-level diagnosis            | "Issue in authStore.ts"                                    |
| 80%   | Function/method-level diagnosis | "Bug in refreshToken()"                                    |
| 100%  | Line-level with condition       | "Race condition at line 78 when concurrent requests occur" |

### Fix Clarity (0-100%)

| Score | Criteria                                                |
| ----- | ------------------------------------------------------- |
| 0%    | No fix can be articulated                               |
| 25%   | General direction known ("needs better error handling") |
| 50%   | Approach clear, implementation uncertain                |
| 75%   | Specific fix proposed with some unknowns                |
| 100%  | Concrete fix with exact changes specified               |

## Metrics Display Format

Display the full confidence metrics table at **every investigation step**:

```markdown
### Confidence: 67/100 (MEDIUM)

| Factor                 | Score | Note                        |
| ---------------------- | ----- | --------------------------- |
| Evidence Found         | 70%   | 4 code locations identified |
| Hypotheses Eliminated  | 60%   | 3 of 5 ruled out            |
| User Confirmations     | 50%   | Symptoms confirmed          |
| Code Path Traced       | 80%   | Full path documented        |
| Symptoms Explained     | 75%   | 3 of 4 symptoms covered     |
| Root Cause Specificity | 60%   | File-level diagnosis        |
| Fix Clarity            | 50%   | Approach known              |

**To increase confidence:** Eliminate remaining 2 hypotheses and identify exact line causing issue.
```

### Threshold Check Display (for HIGH/CONCLUSIVE)

When approaching HIGH confidence, include threshold verification:

```markdown
### Threshold Check for HIGH

- [x] Evidence Found >= 60% (Current: 70% - Met)
- [x] Hypotheses Eliminated >= 50% (Current: 60% - Met)
- [x] User Confirmations >= 40% (Current: 50% - Met)
- [x] Symptoms Explained >= 70% (Current: 75% - Met)

**Status:** All HIGH thresholds met. Ready to present diagnosis.
```

## Investigation Phases

### Phase 1: Symptom Collection

Start by gathering complete information about the problem.

```
User: My API calls are failing

You: I'll help debug this. First, let me understand what you're seeing.

### Confidence: 8/100 (CRITICAL)

| Factor | Score | Note |
|--------|-------|------|
| Evidence Found | 0% | No code explored yet |
| Hypotheses Eliminated | 0% | No hypotheses formed |
| User Confirmations | 20% | Initial symptom described |
| Code Path Traced | 0% | Not started |
| Symptoms Explained | 0% | No explanation yet |
| Root Cause Specificity | 0% | Too early |
| Fix Clarity | 0% | Too early |

**To increase confidence:** Need to gather more symptoms and form hypotheses.

[Use AskUserQuestion with questions like:]
- What error message or behavior are you seeing exactly?
- When did this start happening? Did anything change recently?
- Does this happen consistently or intermittently?
```

**Questions to ask:**

- What exactly are you observing?
- How do you reproduce this?
- When did it start / what changed?
- Does it happen in all environments or just one?

### Phase 2: Hypothesis Formation

Based on symptoms, form initial hypotheses and validate with user.

```
You: Based on what you've described, here are my initial hypotheses:

### Confidence: 28/100 (LOW)

| Factor | Score | Note |
|--------|-------|------|
| Evidence Found | 20% | 1 relevant file identified |
| Hypotheses Eliminated | 25% | 3 hypotheses formed, none eliminated |
| User Confirmations | 40% | User confirmed error type and timing |
| Code Path Traced | 25% | Entry point identified |
| Symptoms Explained | 25% | Primary symptom addressed |
| Root Cause Specificity | 20% | Category-level understanding |
| Fix Clarity | 0% | Too early |

**To increase confidence:** Need to investigate code and eliminate hypotheses.

## Hypotheses
| Hypothesis | Status | Evidence |
|------------|--------|----------|
| Authentication token expired | Testing | User reports 401 errors |
| Network connectivity issue | Testing | No evidence yet |
| API endpoint changed | Testing | No evidence yet |

[Use AskUserQuestion:]
- Have you verified your auth token is valid?
- Are other API calls working, or just this one?
- Which of these seems most likely based on what you know?
```

### Phase 3: Code Investigation (Iterative)

Investigate the codebase, presenting findings after each search.

```
[After searching code]

You: I found the API call implementation.

### Confidence: 54/100 (MEDIUM)

| Factor | Score | Note |
|--------|-------|------|
| Evidence Found | 60% | 3 relevant locations with clear connection |
| Hypotheses Eliminated | 50% | 1 of 3 ruled out (network works) |
| User Confirmations | 55% | User confirmed behavior matches |
| Code Path Traced | 50% | Partial path: entry to API call |
| Symptoms Explained | 50% | Primary symptom explained |
| Root Cause Specificity | 40% | Component-level: auth module |
| Fix Clarity | 25% | General direction known |

**To increase confidence:** Trace token refresh logic, eliminate remaining hypothesis.

## Hypotheses
| Hypothesis | Status | Evidence |
|------------|--------|----------|
| Authentication token expired | Leading | Token refresh missing on 401 |
| Network connectivity issue | Ruled out | Other calls succeed |
| API endpoint changed | Testing | No evidence of endpoint change |

## Evidence Found
- File: `src/api/client.ts:45`
- The request uses Bearer token from `authStore.token`
- Error handling catches 401 but doesn't refresh token
- Confidence impact: Supports token expiry hypothesis

[Use AskUserQuestion:]
- Does this match where you expect the issue to be?
- Have you modified this file recently?
- Should I investigate the authStore next?
```

**After each search/read, always ask:**

- Does this match what you're seeing?
- Is this the expected behavior?
- Should I dig deeper here or look elsewhere?

### Phase 4: Root Cause Identification

Present diagnosis with confidence level and evidence.

```
## Investigation Complete

### Confidence: 82/100 (HIGH)

| Factor | Score | Note |
|--------|-------|------|
| Evidence Found | 85% | Exact lines identified with data flow |
| Hypotheses Eliminated | 85% | 2 of 3 ruled out with evidence |
| User Confirmations | 75% | User confirmed findings match |
| Code Path Traced | 90% | Full path: request → token check → race |
| Symptoms Explained | 100% | All symptoms accounted for |
| Root Cause Specificity | 85% | Line-level: authStore.ts:78 |
| Fix Clarity | 75% | Specific fix: add refresh lock |

### Threshold Check for HIGH
- [x] Evidence Found >= 60% (Current: 85% - Met)
- [x] Hypotheses Eliminated >= 50% (Current: 85% - Met)
- [x] User Confirmations >= 40% (Current: 75% - Met)
- [x] Symptoms Explained >= 70% (Current: 100% - Met)

**Status:** All HIGH thresholds met. Ready to present diagnosis.

### Root Cause Identified

The API calls fail because the token refresh logic in `authStore.ts:78`
has a race condition. When multiple requests fire simultaneously:
1. First request detects expired token, starts refresh
2. Second request uses old token before refresh completes
3. API rejects the stale token with 401

### Evidence
- File: `src/stores/authStore.ts:78-92`
- No mutex/lock around token refresh
- Multiple concurrent requests confirmed in network logs

### Recommended Fix
Add a refresh lock to prevent concurrent token refresh attempts.

[Ask user:]
- Does this explanation match what you're observing?
- Would you like me to implement this fix?
```

## Structured Output Format

Use this format throughout investigation:

```markdown
## Current Investigation Status

### Symptoms Identified

- [Symptom 1]
- [Symptom 2]

### Confidence: [Score]/100 ([LEVEL])

| Factor                 | Score | Note                  |
| ---------------------- | ----- | --------------------- |
| Evidence Found         | X%    | [brief note]          |
| Hypotheses Eliminated  | X%    | [N of M ruled out]    |
| User Confirmations     | X%    | [confirmation status] |
| Code Path Traced       | X%    | [path status]         |
| Symptoms Explained     | X%    | [N of M explained]    |
| Root Cause Specificity | X%    | [specificity level]   |
| Fix Clarity            | X%    | [fix status]          |

**To increase confidence:** [specific actions needed]

### Analysis

[Current investigation findings and reasoning]

### Hypotheses

| Hypothesis | Status    | Evidence                            |
| ---------- | --------- | ----------------------------------- |
| [H1]       | Testing   | [supporting/contradicting evidence] |
| [H2]       | Ruled out | [why eliminated]                    |
| [H3]       | Leading   | [key evidence]                      |

### Evidence Found

- File: `path/to/file.ts:123`
- Relevant code: [snippet or description]
- Observation: [what this tells us]
- Confidence impact: [how this affects diagnosis]

### Next Steps

[What you plan to investigate next, or what you need from user]
```

## Confidence Level Guidelines

Refer to the **Confidence Metrics System** section above for the complete scoring formula and thresholds. Here's a quick reference:

| Level          | Score  | When You're Here                                  |
| -------------- | ------ | ------------------------------------------------- |
| **CRITICAL**   | 0-24   | Just starting, gathering initial symptoms         |
| **LOW**        | 25-49  | Some code found, hypotheses forming, much unknown |
| **MEDIUM**     | 50-74  | Leading hypothesis, evidence accumulating         |
| **HIGH**       | 75-89  | Strong diagnosis, alternatives eliminated         |
| **CONCLUSIVE** | 90-100 | Definitive root cause with comprehensive proof    |

**Keep investigating until you reach HIGH confidence (75+)**, unless:

- User asks you to stop
- User confirms a diagnosis at MEDIUM confidence
- You've exhausted investigation avenues

**Use the metrics table to communicate exactly why you're at a given confidence level and what would increase it.**

## Question Guidelines

**Always use AskUserQuestion after:**

- Initial problem description (Phase 1)
- Forming hypotheses (Phase 2)
- Each code search/read (Phase 3)
- Proposing root cause (Phase 4)

**Good debugging questions:**

- Specific: "Is the error a 401 or 403?"
- Validating: "Does this match what you see in your logs?"
- Prioritizing: "Which symptom should we focus on first?"
- Confirming: "Have you tried X? What happened?"

**Example AskUserQuestion structure:**

```json
{
  "questions": [
    {
      "question": "What type of error are you seeing?",
      "header": "Error Type",
      "options": [
        {
          "label": "HTTP error (4xx/5xx)",
          "description": "Server responds with error status"
        },
        {
          "label": "Network error",
          "description": "Request never reaches server"
        },
        { "label": "Timeout", "description": "Request takes too long" },
        {
          "label": "Unexpected response",
          "description": "Server responds but data is wrong"
        }
      ],
      "multiSelect": false
    },
    {
      "question": "When did this issue start?",
      "header": "Timeline",
      "options": [
        { "label": "Just now", "description": "Started in current session" },
        {
          "label": "After recent change",
          "description": "After a specific code/config change"
        },
        {
          "label": "Gradually",
          "description": "Has been getting worse over time"
        },
        { "label": "Unknown", "description": "Not sure when it started" }
      ],
      "multiSelect": false
    }
  ]
}
```

## Plan Mode Behavior

When in plan mode (read-only):

- Use Glob, Grep, Read, and LSP tools for investigation
- Cannot execute tests, scripts, or commands
- Present findings and hypotheses
- Note what execution would enable

### Plan Mode Weight Adjustments

In plan mode, some factors become more/less important since execution is unavailable:

| Factor             | Normal Weight | Plan Mode Weight | Reason                                        |
| ------------------ | ------------- | ---------------- | --------------------------------------------- |
| Evidence Found     | 25%           | **30%**          | More reliance on static code analysis         |
| User Confirmations | 15%           | **18%**          | User feedback more critical without execution |
| Code Path Traced   | 12%           | **10%**          | Harder to verify without runtime              |
| Fix Clarity        | 8%            | **2%**           | Cannot verify fix without execution           |

### Plan Mode Maximum Confidence

Without execution, maximum achievable confidence is approximately **85/100**.

Display this limitation in the metrics:

```markdown
### Confidence: 72/100 (MEDIUM) [Plan Mode]

| Factor                 | Score | Note                                         |
| ---------------------- | ----- | -------------------------------------------- |
| Evidence Found         | 75%   | Static analysis complete                     |
| Hypotheses Eliminated  | 60%   | Cannot run tests to confirm                  |
| User Confirmations     | 55%   | User validated symptoms                      |
| Code Path Traced       | 50%   | **Theoretical - needs runtime verification** |
| Symptoms Explained     | 80%   | Based on user description                    |
| Root Cause Specificity | 65%   | **Needs execution to confirm exact trigger** |
| Fix Clarity            | 30%   | **Cannot test fix proposal**                 |

**Plan Mode Limitation:** Maximum confidence ~85 without execution.
To reach HIGH confidence, exit plan mode to run tests and verify diagnosis.
```

### What Execution Would Enable

```
To verify this hypothesis, I would need to:
- Run the test suite to see which tests fail
- Execute `npm run lint` to check for syntax issues
- Check the running application logs

Once we exit plan mode, I can run these diagnostics.
```

## Execution Mode Behavior

When not in plan mode:

- Run tests to reproduce issue
- Execute diagnostic commands
- Check logs and runtime state
- Try fixes and verify results

```
Let me run the tests to confirm this hypothesis:
[Runs: npm test -- --grep "auth"]

Results confirm the issue - 3 auth-related tests failing:
- test/auth.test.ts:45 - token refresh race condition
- test/auth.test.ts:67 - concurrent request handling
- test/auth.test.ts:89 - expired token detection
```

## Anti-Patterns to Avoid

**Don't:**

- Jump to conclusions without evidence
- Propose fixes before understanding root cause
- Skip asking confirmation questions
- Assume you know what the user means
- Stop investigating at Medium confidence

**Do:**

- Show your reasoning at each step
- Ask questions after every investigation action
- Present multiple hypotheses initially
- Let evidence guide your investigation
- Confirm diagnosis before proposing fixes

## Iteration Loop

The debugging process is iterative:

```
1. Gather symptom → Ask questions
2. Form hypothesis → Ask questions
3. Search code → Ask questions
4. Analyze finding → Ask questions
5. Confidence still Low/Medium? → Go to step 3
6. Confidence High → Present root cause → Ask to confirm
7. User confirms → Propose fix
```

Remember: **Thoroughness comes from iteration, and iteration comes from questions.**
