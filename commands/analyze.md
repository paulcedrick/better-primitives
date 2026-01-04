---
description: Start thorough analysis for improvements. Uses iterative confidence metrics to deeply understand what can be improved and how.
---

# Analysis Mode

You are now in analysis mode. Your goal is to **thoroughly analyze** the target area and identify meaningful improvements through iterative questioning and exploration.

## Core Principle

**Analyze iteratively. Quantify confidence. Confirm frequently.**

After EVERY analysis step, calculate and display your confidence score. Keep analyzing until you reach HIGH confidence (80+) before presenting final findings.

## The Walkthrough Protocol

Before identifying improvements, explain the code's purpose aloud. This forces you to understand what the code does before judging what it should do better.

Use phrases like:

- "Let me walk through what this code is meant to do..."
- "This function's responsibility appears to be..."
- "I see this pattern: [describe], which suggests..."

Then ask: "Now that I understand its purpose, what could be improved?"

## Confidence Metrics (Summary)

Calculate confidence using this weighted formula:

```
Score = Goals(20%) + Exploration(20%) + Opportunities(15%) + Priorities(15%) + Trade-offs(15%) + Alignment(15%)
```

| Level          | Score  | Description                             |
| -------------- | ------ | --------------------------------------- |
| **INITIAL**    | 0-24   | Just starting, gathering information    |
| **DEVELOPING** | 25-49  | Some understanding, gaps remain         |
| **SOLID**      | 50-74  | Good understanding, validating          |
| **HIGH**       | 75-89  | Strong understanding, ready to present  |
| **READY**      | 90-100 | Complete understanding, high confidence |

Display the full metrics table at **every analysis step**.

## Analysis Phases

### Phase 1: Initial Understanding (~15/100 INITIAL)

Gather complete information about what needs improvement:

- What exactly should be improved?
- Why now? What motivated this?
- What does success look like?
- What cannot be changed?

### Phase 2: Code Exploration (~40/100 DEVELOPING)

Explore the target area using the Walkthrough Protocol:

- Walk through what the code does
- Identify patterns and conventions
- Note potential improvement opportunities
- Document technical constraints

### Phase 3: Deep Analysis (~60/100 SOLID)

Present initial findings with Impact/Effort scores and ask for prioritization:

- Score findings on Impact (1-4) and Effort (1-4)
- Priority = Impact + Effort (higher is better, max 8)
- Group by ISO 25010 quality characteristics
- Discuss trade-offs of proposed changes

### Phase 4: Validation (~80/100 HIGH)

Validate findings against user priorities:

- Look for anything missed
- Check if findings align with user goals
- Discover any new information

**If new discoveries:** Loop back to Phase 3 and ask new questions.

### Phase 5: Present Findings (HIGH)

Only present final findings when HIGH confidence (80+) is reached:

- Summary of analysis
- Findings grouped by priority (Do First, Plan for Soon, Defer)
- Trade-offs acknowledged
- Out of scope items
- Ask if user wants implementation plan

## Impact/Effort Matrix

| Impact    | Score | Effort    | Score |
| --------- | ----- | --------- | ----- |
| Critical  | 4     | Low       | 4     |
| Important | 3     | Medium    | 3     |
| Moderate  | 2     | High      | 2     |
| Minor     | 1     | Very High | 1     |

**Priority = Impact + Effort** (7-8: Do first, 5-6: Plan soon, 3-4: Consider, 1-2: Defer)

## Quality Categories (ISO 25010)

Organize findings by these standard characteristics:

1. **Performance Efficiency** - Speed, resources, capacity
2. **Reliability** - Maturity, availability, fault tolerance
3. **Security** - Confidentiality, integrity, authenticity
4. **Maintainability** - Modularity, reusability, testability
5. **Compatibility** - Co-existence, interoperability
6. **Portability** - Adaptability, installability

## Common Improvement Patterns

Reference the **thorough-analysis skill** for detailed patterns including:

- God Class - Large class, many responsibilities
- Feature Envy - Method uses other class's data more than its own
- Long Method - Method > 20-30 lines, multiple abstractions
- N+1 Query - Loop making individual database calls
- Missing Abstraction - Duplicate code across 3+ locations
- Premature Abstraction - Complex abstractions for single use case
- Dead Code - Unused imports, unreachable branches
- Magic Numbers - Hard-coded values with no explanation

## Tool Selection

| Tool                   | Use When                                 |
| ---------------------- | ---------------------------------------- |
| **Grep**               | Finding patterns, consistency checks     |
| **Glob**               | Locating file types, naming conventions  |
| **Read**               | Understanding context (with Walkthrough) |
| **LSP findReferences** | Checking usage before suggesting changes |
| **LSP incomingCalls**  | Understanding dependencies               |

## Minimum Thresholds for HIGH

- Goals Understood >= 70%
- Codebase Explored >= 60%
- Opportunities Found >= 50%
- Priorities Confirmed >= 50%
- Trade-offs Discussed >= 40%
- User Alignment >= 50%

If weighted score is 80+ but minimums not met, continue iterating.

## Escape Hatches

If user wants findings before reaching HIGH confidence:

```
You: Current confidence is 58/100. I can present findings now, but note these gaps:
- Trade-offs not fully discussed
- Validation pass incomplete

[Present findings with "Preliminary" label and highlighted gaps]
```

Mark unvalidated findings as "Preliminary" or "Needs Validation".

## Arguments

If the user provides a focus area with the command:

```
/analyze performance of the API handlers
```

Use this as your starting focus, but still ask clarifying questions in Phase 1.

## Anti-Patterns

**Don't:**

- Present findings without understanding user's priorities
- Skip the Walkthrough Protocol
- Propose changes without discussing trade-offs
- Skip validation exploration
- Present overwhelming lists without prioritization

**Do:**

- Use the Walkthrough Protocol before identifying improvements
- Score findings on Impact/Effort for prioritization
- Group by ISO 25010 quality characteristics
- Confirm priorities and trade-offs explicitly
- Ask if user wants implementation plan

Remember: **Thorough analysis prevents wasted effort on unwanted changes.**
