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

## The Rubber Duck Protocol

Before forming hypotheses, explain the code aloud. This forces you to slow down and articulate your understanding. Bugs often hide in the gap between "what you think the code does" and "what it actually does."

**Apply it:**

```markdown
Before investigating the suspect code, I'll explain what I understand it to do:

1. When the user clicks "Submit", the `handleSubmit` function is called
2. This function calls `validateForm()` which returns true/false
3. If valid, it calls `submitToAPI()` which returns a Promise
4. On success, it updates state with `setResult(data)`
5. On error, it... [pause] - I don't see error handling here.

**Wait - the code doesn't handle the error case from submitToAPI.**
That could explain why the form "freezes" on network errors.
```

This "explain it to discover" pattern is explicitly encouraged. Use phrases like:

- "Let me walk through what this code does..."
- "Following the execution path..."
- "I expected X at this point, but I see Y..."

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

## Debugging Tool Selection

Choose the right tool for each investigation step:

### Static Analysis (Plan Mode Compatible)

| Tool                   | Use When                                           | Example                                |
| ---------------------- | -------------------------------------------------- | -------------------------------------- |
| **Grep**               | Searching for string patterns, error messages      | `Grep pattern="401.*auth" path="src/"` |
| **Glob**               | Finding files by pattern                           | `Glob pattern="**/*auth*.ts"`          |
| **Read**               | Understanding code context, reading full functions | `Read file_path="src/auth/login.ts"`   |
| **LSP goToDefinition** | Finding where something is defined                 | Navigate to function source            |
| **LSP findReferences** | Finding all usages                                 | See everywhere a function is called    |
| **LSP incomingCalls**  | Call hierarchy - who calls this                    | Trace callers of suspect function      |

### Runtime Analysis (Execution Mode Only)

| Tool                      | Use When                        | Example                              |
| ------------------------- | ------------------------------- | ------------------------------------ |
| **Bash (tests)**          | Reproducing bug, validating fix | `npm test -- --grep "auth"`          |
| **Bash (diagnostic)**     | Checking runtime state          | `curl -v http://localhost:3000/api`  |
| **Console.log insertion** | Tracing execution flow          | Add temporary logs, run, read output |
| **Debugger/Breakpoints**  | Complex state inspection        | (Note: Cannot do interactively)      |

### Tool Selection Decision Tree

```
Is the bug reproducible via tests?
├── Yes → Run tests first to confirm (Bash)
└── No → Analyze code statically first (Grep/Read/LSP)
         │
         └── Found suspect code?
             ├── Yes → Trace call hierarchy (LSP incomingCalls)
             └── No → Broaden search (Grep with related terms)
```

## Experiment Design for Hypothesis Testing

For each hypothesis, design a specific experiment before investigating:

### Experiment Template

```markdown
### Experiment for Hypothesis: [H1]

**Prediction:** If [H1] is the cause, then [specific action] should produce [expected result].

**Test:**

- Action: [command, code change, or observation to perform]
- Expected if H1 is true: [result]
- Expected if H1 is false: [different result]

**Result:** [To be filled after execution]
**Conclusion:** [Supports/Refutes/Inconclusive for H1]
```

### Example Experiments

**Hypothesis: Token refresh has a race condition**

- Action: Add a 500ms delay before token refresh
- Expected if true: Bug disappears or becomes less frequent
- Expected if false: Bug persists unchanged

**Hypothesis: Null reference from uninitialized prop**

- Action: Add console.log for prop value at component mount
- Expected if true: Log shows undefined/null
- Expected if false: Log shows valid value

**Hypothesis: Off-by-one error in loop**

- Action: Test with array of length 0, 1, and 2
- Expected if true: Fails at boundary (length 0 or max index)
- Expected if false: Works for all array sizes

### Experiment Types by Tool

| Tool        | Experiment Type    | Example                                      |
| ----------- | ------------------ | -------------------------------------------- |
| Bash        | Runtime validation | Run with debug flags, specific inputs        |
| Read/Grep   | Static analysis    | Check if code path exists                    |
| LSP         | Call hierarchy     | Trace all callers of suspect function        |
| Console.log | Value inspection   | Log state at key points                      |
| Breakpoint  | State inspection   | Pause and inspect variables                  |
| Bisection   | Isolation          | Disable half the code, check if bug persists |

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

### Phase 1.5: Reproduction (Optional but Recommended)

Before forming hypotheses, attempt to reproduce the bug:

**Questions to ask:**

- Can you reproduce this consistently?
- What are the exact steps to trigger the bug?
- Does it occur in specific environments only?

**If reproducible:**

```markdown
I've confirmed the bug reproduces with these steps:

1. [step 1]
2. [step 2]
3. Expected: [X], Actual: [Y]

This increases confidence that we're investigating the right issue.
```

**If intermittent:**

```markdown
This appears to be an intermittent bug. I'll note the reproduction conditions:

- Frequency: [X% of the time]
- Known triggers: [conditions]
- Possible Heisenbug: [yes/no - see Special Bug Types section]
```

**Impact on Confidence:**

- Reproduced: Evidence Found +10%, Symptoms Explained +15%
- Not reproduced: Evidence Found capped at 60%, note in metrics

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

Investigate the codebase, presenting findings after each search. **For each hypothesis, design an experiment before investigating.**

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

## Experiment for Leading Hypothesis
**Prediction:** If token refresh is the cause, then adding a manual token refresh before the API call should fix the issue.
**Test:** Temporarily add `await refreshToken()` before the failing API call.
**Expected if true:** API call succeeds after manual refresh.

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

### Phase 5: Fix Verification

After implementing a fix, verify it resolves the issue:

```markdown
## Fix Verification

### Confidence: 92/100 (CONCLUSIVE)

| Factor                 | Score | Note                        |
| ---------------------- | ----- | --------------------------- |
| Evidence Found         | 95%   | Root cause + fix identified |
| Hypotheses Eliminated  | 100%  | Single hypothesis confirmed |
| User Confirmations     | 85%   | Diagnosis confirmed         |
| Code Path Traced       | 100%  | Full path documented        |
| Symptoms Explained     | 100%  | All symptoms resolved       |
| Root Cause Specificity | 95%   | Line-level with fix         |
| Fix Clarity            | 100%  | Fix implemented & verified  |

### Verification Checklist

- [ ] Original bug no longer reproduces
- [ ] Existing tests still pass
- [ ] No new test failures introduced
- [ ] Related functionality still works
- [ ] Edge cases handled (if applicable)

### Verification Results

**Reproduction test:** [pass/fail]
**Test suite:** [X tests pass, Y fail]
**Regression check:** [any new issues?]
**Side effects:** [none observed / potential issue with X]
```

**Only mark the investigation as complete after verification passes.**

## Special Bug Types: Heisenbugs and Race Conditions

Some bugs require special debugging tactics because they're sensitive to observation.

### Heisenbug Detection

A Heisenbug is a bug that disappears or changes when you try to study it:

- Bug disappears when adding console.log
- Bug doesn't reproduce in debugger
- Bug is intermittent with no pattern
- Bug only appears under load

**If Heisenbug detected:**

```markdown
**Heisenbug Warning**

This bug exhibits Heisenbug characteristics:

- [Specific behavior observed]

**Special investigation tactics required:**

- Avoid intrusive debugging (no console.log that changes timing)
- Use non-blocking observation (logging frameworks with buffering)
- Consider time-travel debugging if available
- Analyze code statically before runtime verification
```

### Race Condition Investigation

Common indicators:

- Intermittent failures
- Works locally, fails in CI
- Fails under load but not single requests
- "Timing-dependent" behavior

**Investigation tactics:**

1. Identify shared state access points
2. Look for missing locks/synchronization
3. Check for time-of-check-to-time-of-use (TOCTTOU) patterns
4. Draw sequence diagram of concurrent operations
5. Experiment: Add artificial delays to exaggerate the race

**Common patterns:**

- `if (exists) { use(thing) }` - thing can change between check and use
- Multiple requests accessing shared cache without locks
- Promise.all with shared state mutations
- Event handlers modifying same state

## Common Bug Patterns Reference

Use this reference to guide investigation based on bug symptoms.

### Null/Undefined Reference

**Symptoms:** "Cannot read property X of undefined", "undefined is not a function"

**Common Causes:**

- Uninitialized variable/prop
- Async data not loaded yet
- Optional chaining needed
- Incorrect import/export

**Investigation Tactics:**

1. Find the exact line from stack trace
2. Trace data flow backward: where should this value come from?
3. Check initialization order (component mount vs data fetch)
4. Look for missing optional chaining (`?.`)

**Experiment:** Add console.log for the undefined value at its source.

**Example:**

```
User: "I'm getting 'Cannot read property 'name' of undefined' but TypeScript didn't catch it."

Investigation:
1. Find the exact line and variable
2. Check the TypeScript type for that variable
3. Look for `any` type escaping the type system
4. Check API response parsing - is there `as MyType` casting?

Found: API response typed with `as User[]` without validation.
Root cause: Backend can return empty array or null, frontend assumes array of objects.
```

---

### Race Condition / Timing Bug

**Symptoms:** Intermittent failures, works in debug mode, timing-dependent

**Common Causes:**

- Shared state without synchronization
- Missing await/async handling
- Event ordering assumptions
- Cache invalidation timing

**Investigation Tactics:**

1. Identify all shared state access points
2. Draw sequence diagram of concurrent operations
3. Look for TOCTTOU patterns
4. Check for missing locks/semaphores

**Experiment:** Add artificial delays to exaggerate the race.

---

### Off-by-One Error

**Symptoms:** Array index out of bounds, wrong loop count, fencepost errors

**Common Causes:**

- `<` vs `<=` confusion
- Zero-based vs one-based indexing
- `length` vs `length - 1`
- Inclusive vs exclusive ranges

**Investigation Tactics:**

1. Test with arrays of size 0, 1, 2
2. Add boundary assertions
3. Check loop bounds explicitly
4. Trace exact iteration values

**Experiment:** Log loop counter and array length at each iteration.

---

### Async/Promise Bug

**Symptoms:** Unresolved promises, missing data, unhandled rejections

**Common Causes:**

- Missing `await` keyword
- Promise not returned
- Error not caught
- Race between promises

**Investigation Tactics:**

1. Check async stack traces (Chrome DevTools)
2. Look for floating promises (no await, no .then)
3. Check error handling (.catch, try/catch)
4. Verify promise resolution order

**Experiment:** Add `.catch(console.error)` to suspected promise.

---

### State Management Bug (React/Vue/etc.)

**Symptoms:** Stale state, unexpected re-renders, state not updating

**Common Causes:**

- Direct state mutation (instead of setter)
- Stale closure over state
- Missing dependency in useEffect
- Incorrect comparison (reference vs value)

**Investigation Tactics:**

1. Log state changes with timestamps
2. Use React DevTools to inspect state
3. Check useEffect dependencies
4. Look for object/array mutation

**Experiment:** Replace mutation with immutable update, verify behavior changes.

**Example:**

```
User: Button click doesn't update the displayed count.

Investigation:
1. Check if setState is being called (add console.log)
2. Check if component re-renders (React DevTools)
3. Check for stale closure in event handler
4. Check if state is mutated vs set via setter

Found: Event handler has stale closure over `count` variable.
Evidence: `useCallback` dependency array missing `count`.
Fix: Add `count` to useCallback dependencies, or use functional updater `setCount(c => c + 1)`.
```

---

### Memory Leak

**Symptoms:** Growing memory over time, performance degradation, eventual crash

**Common Causes:**

- Event listeners not removed
- Interval/timeout not cleared
- Closure capturing large objects
- Caching without eviction

**Investigation Tactics:**

1. Take heap snapshots over time
2. Look for growing retained sizes
3. Check cleanup in useEffect returns
4. Search for addEventListener without removeEventListener

**Experiment:** Run garbage collection, compare heap before/after.

---

### Type Mismatch (JavaScript/TypeScript)

**Symptoms:** Unexpected behavior, "NaN", string concatenation instead of addition

**Common Causes:**

- `any` type escaping validation
- Runtime data not matching expected type
- Incorrect API response shape
- Missing type guards

**Investigation Tactics:**

1. Add `typeof` / `instanceof` checks
2. Log actual value and type at error point
3. Trace value from source (API, user input)
4. Check TypeScript strict mode

**Experiment:** Add runtime type guard, throw if type unexpected.

---

### Build/Compile Error

**Symptoms:** Build fails, type errors, import errors

**Common Causes:**

- Missing dependency
- Version mismatch
- Circular import
- Incorrect tsconfig/babel config

**Investigation Tactics:**

1. Read error message carefully (line, file, reason)
2. Check package.json versions
3. Try clean build (rm -rf node_modules, fresh install)
4. Check import graph for cycles

**Experiment:** Isolate the failing import/file, build incrementally.

**Example:**

```
User: Build passes locally, fails in CI with type errors.

Investigation:
1. Compare Node/npm versions (CI vs local)
2. Check if node_modules is cached incorrectly
3. Compare tsconfig strict settings
4. Check for OS-specific path issues (case sensitivity)

Found: CI runs with `strict: true`, local has `strict: false`.
Fix: Enable strict mode locally, fix reported type issues.
```

---

### Flaky Test

**Symptoms:** Test passes sometimes, fails randomly, order-dependent

**Common Causes:**

- Shared state between tests
- Timing assumptions (setTimeout, animation frames)
- External dependency (network, file system)
- Random data without seeding

**Investigation Tactics:**

1. Run test in isolation vs with other tests
2. Run test multiple times in a row
3. Check for shared state (global variables, singletons)
4. Add explicit waits for async operations

**Experiment:** Run suspect test 100x in isolation, note failure rate.

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

### Experiment for Leading Hypothesis

**Prediction:** If [H] is true, then [action] should produce [result].
**Test:** [specific command or action]

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
- Reproduction attempt (Phase 1.5)
- Forming hypotheses (Phase 2)
- Each code search/read (Phase 3)
- Proposing root cause (Phase 4)
- Verifying fix (Phase 5)

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
- Add logging that changes timing for race conditions (Heisenbug risk)
- Ignore intermittent behavior as "random"
- Skip the verification phase after implementing a fix

**Do:**

- Show your reasoning at each step
- Ask questions after every investigation action
- Present multiple hypotheses initially
- Design experiments for each hypothesis
- Let evidence guide your investigation
- Confirm diagnosis before proposing fixes
- Verify fixes resolve the issue before closing
- Use the Rubber Duck Protocol to explain code before hypothesizing

## Iteration Loop

The debugging process is iterative:

```
1. Gather symptom → Ask questions
2. Reproduce bug (optional) → Ask questions
3. Form hypothesis → Design experiment → Ask questions
4. Search code / Run experiment → Ask questions
5. Analyze finding → Ask questions
6. Confidence still Low/Medium? → Go to step 4
7. Confidence High → Present root cause → Ask to confirm
8. User confirms → Propose fix
9. Implement fix → Verify → Ask to confirm resolution
```

Remember: **Thoroughness comes from iteration, and iteration comes from questions.**
