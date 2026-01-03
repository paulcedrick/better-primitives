---
name: thorough-planning
description: Enhances planning by making Claude proactively ask in-depth questions. Triggers when planning implementations, designing features, or when user requests involve ambiguity. Use this to ensure complete understanding before writing code.
---

# Thorough Planning Skill

When planning any implementation, feature, or significant code change, follow this questioning-first approach.

## Triggering Conditions

Activate this skill when:

- User asks to implement a feature
- User asks to add, modify, or refactor code
- User describes a problem to solve
- User's request has ambiguity or multiple valid interpretations
- You're about to make assumptions about what the user wants

## Core Behavior

### 1. Question Before You Explore

Before diving into the codebase, clarify the request:

```
User: Add user authentication to the app

You: Before I explore your codebase, I want to make sure I understand what you need.
[Use AskUserQuestion with questions like:]
- What authentication method? (OAuth providers, JWT, session-based, magic links)
- What's the user flow? (login only, or also signup, password reset, email verification)
- Any specific security requirements? (MFA, rate limiting, audit logging)
```

### 2. Question After You Explore

After understanding the codebase, surface technical decisions:

```
[After exploring code]

You: I've looked at your codebase. I see you're using Express with PostgreSQL.
[Use AskUserQuestion with questions like:]
- Should I use Passport.js (common pattern) or build custom auth middleware?
- I noticed no user table exists. Should I create the schema, or is that separate?
- Your API uses /api/v1 prefix. Should auth routes follow this pattern?
```

### 3. Confirm Before Planning

Summarize understanding before finalizing:

```
You: Here's my understanding:
- You want JWT-based auth with email/password login
- Including signup and password reset flows
- Following your existing Express patterns
- Creating a new users table in PostgreSQL

Is this correct? Anything to add or change before I create the implementation plan?
```

## Question Categories

Always consider questions across these dimensions:

### Requirements

- What exactly should be built?
- What problem does this solve?
- What are the edge cases?
- What does success look like?
- What are the constraints?

### Scope

- MVP or production-ready?
- What's in vs out of scope?
- What can be deferred?
- Related changes to consider?

### Technical

- Which patterns to follow?
- Which libraries to use?
- Trade-offs between approaches?
- How does this fit existing architecture?

## Using AskUserQuestion

Prefer `AskUserQuestion` tool when:

- There are 2-4 clear options to choose from
- User preference directly affects implementation
- You'd otherwise make an assumption

Example structure:

```json
{
  "questions": [
    {
      "question": "Which authentication approach should we use?",
      "header": "Auth Method",
      "options": [
        {
          "label": "JWT tokens",
          "description": "Stateless, good for APIs and mobile apps"
        },
        {
          "label": "Session-based",
          "description": "Traditional, good for web apps with server rendering"
        },
        {
          "label": "OAuth only",
          "description": "Delegate to providers like Google, GitHub"
        }
      ],
      "multiSelect": false
    }
  ]
}
```

## Anti-Patterns to Avoid

**Don't:**

- Jump straight into code exploration without understanding intent
- Make assumptions when you could ask
- Present a plan without confirming understanding
- Ask vague questions ("How should this work?")
- Ask too many questions at once (max 4 per round)

**Do:**

- Ask specific, actionable questions
- Give context for why you're asking
- Present trade-offs when relevant
- Confirm understanding before planning
- Be willing to ask follow-up questions

## Output Quality

A thorough planning process results in:

- Clear, specific implementation steps
- Explicit decisions (not assumptions)
- Acknowledgment of user preferences
- Minimal surprises during implementation

Remember: **Confidence comes from understanding, and understanding comes from questions.**
