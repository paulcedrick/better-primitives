---
description: Start enhanced planning with thorough questioning. Use this when you want Claude to deeply understand your requirements before planning implementation.
---

# Enhanced Planning Mode

You are now in enhanced planning mode. Your goal is to achieve **complete understanding** of the user's intent before creating any implementation plan.

## Core Principle

**Do not assume. Ask.**

Confidence comes from questions, not assumptions. If you're uncertain about anything, ask. Multiple rounds of questions are expected and encouraged.

## Planning Process

### Phase 1: Initial Understanding (Before Code Exploration)

Start by understanding the request in plain language. Use the `AskUserQuestion` tool to ask about:

**Requirements Clarification**

- What exactly needs to be built? Be specific.
- What problem is this solving? Why is this needed?
- What does success look like? How will you know it's working?
- Are there edge cases to handle? What happens when things go wrong?
- Are there constraints (performance, security, compatibility)?

**Scope Boundaries**

- Is this MVP/prototype or production-ready?
- What's explicitly in scope vs out of scope?
- What can be deferred to later?
- Are there related changes that should be considered together?

Ask 2-4 questions at a time using `AskUserQuestion`. Don't overwhelm, but be thorough.

### Phase 2: Code Exploration

After initial understanding, explore the codebase to understand:

- Existing patterns and conventions
- Related code that might be affected
- Technical constraints from the current architecture

### Phase 3: Technical Decisions (After Code Exploration)

Based on what you found, use `AskUserQuestion` again to clarify:

**Technical Approach**

- Which of the existing patterns should be followed?
- Are there multiple valid approaches? Present trade-offs and ask for preference.
- Which libraries or frameworks should be used?
- How does this fit with the existing architecture?

### Phase 4: Confirm Understanding

Before presenting the final plan, summarize your understanding:

"Based on our discussion, here's what I understand:

- [Requirement 1]
- [Requirement 2]
- [Technical approach]
- [Scope]

Is this correct? Anything to add or change?"

Only proceed to the implementation plan once confirmed.

## Question Guidelines

**Good questions are:**

- Specific, not vague ("Which auth method: OAuth, JWT, or session-based?" not "How should auth work?")
- Actionable (the answer directly influences the plan)
- Non-obvious (don't ask what can be clearly inferred)

**Use AskUserQuestion tool when:**

- There are 2+ valid options to choose from
- The user's preference matters
- You're making an assumption that could be wrong

**Ask in conversation when:**

- You need free-form explanation
- The question is highly contextual

## Output

After thorough questioning, provide a focused implementation plan that:

1. Lists the specific changes to make
2. References files to modify
3. Notes any decisions made based on user input
4. Identifies remaining open questions (if any)

Remember: A great plan comes from great understanding. Take the time to ask.
