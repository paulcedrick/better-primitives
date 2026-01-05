---
name: thorough-design
description: Enables thorough, confidence-driven software architecture design. Triggers when users want to architect new features, understand existing systems, or plan system evolution. Iteratively investigates with frequent confirmation questions until confident in the design.
---

# Thorough Design Skill

When designing any software architecture, understanding existing systems, or planning system evolution, follow this iterative, confidence-driven approach.

## Triggering Conditions

Activate this skill when:

- User invokes `/design` command
- User explicitly asks to "design", "architect", or "structure" something
- User asks for "system design" or "architecture" of a feature

**Note:** This skill is explicit-trigger only. Do not auto-activate on general questions.

## Core Principle

**Understand before designing. Ask, explore, diagram, validate, repeat.**

Keep gathering information until you reach HIGH confidence (80+). Only then present the architecture design.

## The Walkthrough Protocol (Required)

Before designing anything, explain what you understand about the system. This forces you to articulate your understanding and reveals gaps.

**Apply it:**

```markdown
### System Walkthrough

Before designing, let me explain what I understand about this system:

1. **Purpose**: This system handles user authentication for the web application
2. **Current State**: It consists of AuthService, TokenManager, and UserStore
3. **Key Flow**: When login requested → validate credentials → generate JWT → store session
4. **Constraints**: Must maintain backward compatibility with existing API
5. **Extension Goals**: Needs to support OAuth providers in the future

**Understanding established.** Now I can proceed with the design.
```

Use phrases like:

- "Let me walk through what this system does..."
- "This component's responsibility appears to be..."
- "The flow goes: X → Y → Z, and the purpose is..."
- "I notice this constraint: [describe]..."

## Confidence Metrics System

Calculate confidence using this weighted formula:

```
DesignConfidence = (Context × 0.15) + (Components × 0.20) + (Flows × 0.15) +
                   (Boundaries × 0.15) + (Risks × 0.15) + (Trade-offs × 0.10) + (Alignment × 0.10)
```

### Factor Weights

| Factor                | Weight | Description                                   |
| --------------------- | ------ | --------------------------------------------- |
| Context Understanding | 15%    | Purpose, stakeholders, external interactions  |
| Component Clarity     | 20%    | Components, responsibilities, cohesion        |
| Flow Mapping          | 15%    | Data/control flow between components          |
| Boundary Definition   | 15%    | Interfaces, contracts, extension points       |
| Risk Identification   | 15%    | Architectural risks and non-risks (from ATAM) |
| Trade-offs Identified | 10%    | Decisions with competing quality attributes   |
| User Alignment        | 10%    | Confirmations received during design          |

### Confidence Levels

| Level          | Score  | Description                                |
| -------------- | ------ | ------------------------------------------ |
| **INITIAL**    | 0-24   | Just starting, gathering basic information |
| **DEVELOPING** | 25-49  | Some understanding, many gaps remain       |
| **SOLID**      | 50-74  | Good understanding, validating approach    |
| **HIGH**       | 75-89  | Strong understanding, ready to present     |
| **READY**      | 90-100 | Complete understanding, high confidence    |

**Target:** Reach HIGH confidence (80+) before presenting the design.

## Factor Measurement Criteria

### Context Understanding (0-100%)

| Score | Criteria                                                      |
| ----- | ------------------------------------------------------------- |
| 0%    | Purpose unclear, no stakeholder context                       |
| 25%   | Basic purpose understood                                      |
| 50%   | Purpose clear, main stakeholders identified                   |
| 75%   | Full context: purpose, stakeholders, constraints              |
| 100%  | Explicit, confirmed understanding of "why" and business goals |

### Component Clarity (0-100%)

| Score | Criteria                                              |
| ----- | ----------------------------------------------------- |
| 0%    | No components identified                              |
| 25%   | High-level modules known                              |
| 50%   | Key components identified with basic responsibilities |
| 75%   | All components with clear single responsibility       |
| 100%  | Components with cohesion/coupling analysis complete   |

### Flow Mapping (0-100%)

| Score | Criteria                                                 |
| ----- | -------------------------------------------------------- |
| 0%    | No flow understanding                                    |
| 25%   | Entry points identified                                  |
| 50%   | Main happy path documented                               |
| 75%   | All major flows including error paths                    |
| 100%  | Complete flow with edge cases, async patterns documented |

### Boundary Definition (0-100%)

| Score | Criteria                                              |
| ----- | ----------------------------------------------------- |
| 0%    | Boundaries not considered                             |
| 25%   | Module boundaries exist                               |
| 50%   | Interfaces between components identified              |
| 75%   | Clear contracts, extension points marked              |
| 100%  | Full API surface with stability guarantees documented |

### Risk Identification (0-100%)

| Score | Criteria                                              |
| ----- | ----------------------------------------------------- |
| 0%    | Risks not considered                                  |
| 25%   | Aware risks exist but not enumerated                  |
| 50%   | Main architectural risks identified                   |
| 75%   | Risks with severity and likelihood assessed           |
| 100%  | Comprehensive risk catalog with mitigation strategies |

### Trade-offs Identified (0-100%)

| Score | Criteria                                             |
| ----- | ---------------------------------------------------- |
| 0%    | Trade-offs not considered                            |
| 25%   | Trade-offs mentioned but not analyzed                |
| 50%   | Key trade-offs documented with alternatives          |
| 75%   | Trade-offs with ADR-quality rationale                |
| 100%  | Full trade-off matrix with quality attribute impacts |

### User Alignment (0-100%)

| Score | Criteria                                                |
| ----- | ------------------------------------------------------- |
| 0%    | No confirmation questions asked                         |
| 25%   | Questions asked, awaiting response                      |
| 50%   | Basic understanding confirmed                           |
| 75%   | Key design decisions confirmed by user                  |
| 100%  | All major decisions and trade-offs explicitly confirmed |

## Minimum Thresholds for HIGH (80+)

To reach HIGH confidence, these minimums must be met:

- Context Understanding >= 70%
- Component Clarity >= 60%
- Flow Mapping >= 50%
- Boundary Definition >= 50%
- Risk Identification >= 50%
- User Alignment >= 50%

If weighted score is 80+ but minimums not met, continue iterating.

## Displaying Progress

Show the confidence metrics table at **every design step**:

```markdown
### Design Progress: 55/100 (SOLID)

| Factor                | Score | Note                           |
| --------------------- | ----- | ------------------------------ |
| Context Understanding | 80%   | Purpose and stakeholders clear |
| Component Clarity     | 65%   | 5 components identified        |
| Flow Mapping          | 50%   | Happy path documented          |
| Boundary Definition   | 45%   | Main interfaces identified     |
| Risk Identification   | 40%   | 3 risks noted                  |
| Trade-offs Identified | 35%   | Aware of 2 trade-offs          |
| User Alignment        | 60%   | Key decisions confirmed        |

**To increase confidence:** Map error flows and define extension points.
```

## Design Phases

### Phase 1: Context Gathering (~12/100 INITIAL)

Start by understanding the system's purpose and stakeholders.

```markdown
User: Design the payment processing system

You: I'll help design the payment processing architecture. First, let me understand the context.

### Design Progress: 12/100 (INITIAL)

| Factor                | Score | Note                   |
| --------------------- | ----- | ---------------------- |
| Context Understanding | 20%   | Basic request received |
| Component Clarity     | 0%    | No exploration yet     |
| Flow Mapping          | 0%    | Not started            |
| Boundary Definition   | 0%    | Not identified         |
| Risk Identification   | 0%    | Not assessed           |
| Trade-offs Identified | 0%    | Not considered         |
| User Alignment        | 15%   | Initial request only   |

**To increase confidence:** Understand the system's purpose and constraints.

[Use AskUserQuestion:]

- What payment providers need to be supported?
- Is this for a new system or extending an existing one?
- What are the main security/compliance requirements?
```

### Phase 2: Component Discovery (~40/100 DEVELOPING)

Explore the codebase (if existing) and identify components.

```markdown
### Design Progress: 40/100 (DEVELOPING)

| Factor                | Score | Note                          |
| --------------------- | ----- | ----------------------------- |
| Context Understanding | 75%   | Purpose and constraints clear |
| Component Clarity     | 45%   | 4 components identified       |
| Flow Mapping          | 30%   | Entry points known            |
| Boundary Definition   | 25%   | Module boundaries exist       |
| Risk Identification   | 25%   | Aware risks exist             |
| Trade-offs Identified | 20%   | Some trade-offs noted         |
| User Alignment        | 50%   | Context confirmed             |

**To increase confidence:** Map the payment flow and identify interfaces.

### System Walkthrough

Let me explain what I understand so far:

1. **Purpose**: Process payments for e-commerce orders
2. **Components Found**: PaymentGateway, OrderService, TransactionLog, NotificationService
3. **Key Flow**: Order placed → payment initiated → gateway processes → result logged
4. **Constraints**: PCI-DSS compliance required, must support refunds

**Understanding established.** Let me explore the flows further.
```

### Phase 3: Flow and Boundary Mapping (~65/100 SOLID)

Document data/control flows and identify boundaries.

```markdown
### Design Progress: 65/100 (SOLID)

| Factor                | Score | Note                           |
| --------------------- | ----- | ------------------------------ |
| Context Understanding | 85%   | Full context documented        |
| Component Clarity     | 70%   | All components identified      |
| Flow Mapping          | 65%   | Happy + error paths documented |
| Boundary Definition   | 60%   | Interfaces identified          |
| Risk Identification   | 50%   | Main risks listed              |
| Trade-offs Identified | 45%   | Key trade-offs documented      |
| User Alignment        | 70%   | Design direction confirmed     |

**To increase confidence:** Complete risk analysis and validate trade-offs.

[Present flow diagrams and ask for confirmation]
```

### Phase 4: Risk and Trade-off Analysis (~80/100 HIGH)

Complete the ATAM-style analysis.

```markdown
### Design Progress: 82/100 (HIGH)

| Factor                | Score | Note                         |
| --------------------- | ----- | ---------------------------- |
| Context Understanding | 90%   | Full context documented      |
| Component Clarity     | 85%   | Components with SRP verified |
| Flow Mapping          | 80%   | All major flows documented   |
| Boundary Definition   | 75%   | Extension points identified  |
| Risk Identification   | 80%   | Risks with mitigations       |
| Trade-offs Identified | 75%   | ADR-quality documentation    |
| User Alignment        | 85%   | Design direction confirmed   |

### Threshold Check for HIGH

- [x] Context Understanding >= 70% (Current: 90% - Met)
- [x] Component Clarity >= 60% (Current: 85% - Met)
- [x] Flow Mapping >= 50% (Current: 80% - Met)
- [x] Boundary Definition >= 50% (Current: 75% - Met)
- [x] Risk Identification >= 50% (Current: 80% - Met)
- [x] User Alignment >= 50% (Current: 85% - Met)

**Status:** All HIGH thresholds met. Ready to present architecture design.
```

## Diagram Formats

Support both Mermaid and ASCII diagrams. Choose based on context or user preference.

### Mermaid Diagrams

**Context Diagram:**

````markdown
```mermaid
graph TB
    User[User] --> App[Web Application]
    App --> Auth[Auth Service]
    App --> API[External API]
    Auth --> DB[(Database)]
`` `
```
````

**Sequence Diagram:**

````markdown
```mermaid
sequenceDiagram
    participant U as User
    participant A as AuthService
    participant T as TokenManager
    U->>A: Login Request
    A->>A: Validate Credentials
    A->>T: Generate Token
    T-->>A: JWT Token
    A-->>U: Login Success
`` `
```
````

**Component Diagram:**

````markdown
```mermaid
graph LR
    subgraph "Auth Module"
        AS[AuthService]
        TM[TokenManager]
        US[UserStore]
    end
    AS --> TM
    AS --> US
    TM --> US
`` `
```
````

### ASCII Diagrams

**Context Diagram:**

```
┌─────────────────────────────────────────────────────┐
│                   System Context                     │
├─────────────────────────────────────────────────────┤
│                                                      │
│    ┌──────┐         ┌─────────────┐                 │
│    │ User │ ──────> │ Application │                 │
│    └──────┘         └──────┬──────┘                 │
│                            │                         │
│              ┌─────────────┼─────────────┐          │
│              │             │             │          │
│              ▼             ▼             ▼          │
│        ┌─────────┐   ┌─────────┐   ┌─────────┐     │
│        │ Auth    │   │ Payment │   │ External│     │
│        │ Service │   │ Gateway │   │ API     │     │
│        └─────────┘   └─────────┘   └─────────┘     │
│                                                      │
└─────────────────────────────────────────────────────┘
```

**Component Diagram:**

```
┌──────────────────────────────────────┐
│           Auth Module                 │
├──────────────────────────────────────┤
│                                       │
│  ┌─────────────┐    ┌──────────────┐ │
│  │ AuthService │───>│ TokenManager │ │
│  └──────┬──────┘    └──────┬───────┘ │
│         │                  │         │
│         │    ┌─────────────┘         │
│         │    │                       │
│         ▼    ▼                       │
│     ┌───────────┐                    │
│     │ UserStore │                    │
│     └───────────┘                    │
│                                       │
└──────────────────────────────────────┘
```

**Sequence Diagram:**

```
User          AuthService      TokenManager     Database
  │                │                │              │
  │  Login(creds)  │                │              │
  │───────────────>│                │              │
  │                │  Validate      │              │
  │                │───────────────────────────────>│
  │                │                │   User Data  │
  │                │<───────────────────────────────│
  │                │                │              │
  │                │  GenerateJWT   │              │
  │                │───────────────>│              │
  │                │                │              │
  │                │   JWT Token    │              │
  │                │<───────────────│              │
  │   Success+JWT  │                │              │
  │<───────────────│                │              │
  │                │                │              │
```

**Dependency Graph:**

```
                    ┌─────────┐
                    │   App   │
                    └────┬────┘
                         │
          ┌──────────────┼──────────────┐
          │              │              │
          ▼              ▼              ▼
    ┌───────────┐  ┌───────────┐  ┌───────────┐
    │   Auth    │  │  Payment  │  │   User    │
    │  Service  │  │  Service  │  │  Service  │
    └─────┬─────┘  └─────┬─────┘  └─────┬─────┘
          │              │              │
          └──────────────┼──────────────┘
                         │
                         ▼
                   ┌───────────┐
                   │  Database │
                   └───────────┘
```

## Design Output Structure

When confidence >= 80%, present the complete architecture design:

### 1. Context View

```markdown
## 1. Context View

### System Purpose

[Why this system exists, what problem it solves]

### Stakeholders

| Stakeholder | Concern          | Priority |
| ----------- | ---------------- | -------- |
| End Users   | Usability, Speed | High     |
| Developers  | Maintainability  | High     |
| Operations  | Reliability      | High     |
| Business    | Cost, Features   | Medium   |

### External Interactions

[Context Diagram - Mermaid or ASCII]

### System Boundary

- **In Scope**: [what this system handles]
- **Out of Scope**: [what other systems handle]
```

### 2. Component View

```markdown
## 2. Component View

[Component Diagram - Mermaid or ASCII]

### Components

| Component    | Responsibility            | Cohesion |
| ------------ | ------------------------- | -------- |
| AuthService  | Authentication logic      | High     |
| TokenManager | JWT generation/validation | High     |
| UserStore    | User data persistence     | High     |
| AuditLogger  | Security event logging    | High     |

### Cohesion/Coupling Analysis

**High Cohesion** (Good):

- AuthService: Single focus on authentication
- TokenManager: Single focus on token lifecycle

**Coupling Concerns**:

- UserStore tightly coupled to database schema
- Consider: Repository pattern for abstraction
```

### 3. Flow View

```markdown
## 3. Flow View

### Primary Flow: User Authentication

[Sequence Diagram - Mermaid or ASCII]

**Steps:**

1. User submits credentials
2. AuthService validates against UserStore
3. TokenManager generates JWT
4. Success response with token

### Error Flow: Invalid Credentials

[Sequence Diagram - Mermaid or ASCII]

**Steps:**

1. User submits invalid credentials
2. AuthService fails validation
3. AuditLogger records attempt
4. Error response (no token)

### Flow Characteristics

| Flow           | Complexity | Performance Critical | Error Handling |
| -------------- | ---------- | -------------------- | -------------- |
| Login          | Low        | Yes                  | Graceful       |
| Token Refresh  | Low        | Yes                  | Graceful       |
| Password Reset | Medium     | No                   | Graceful       |
```

### 4. Boundary View

```markdown
## 4. Boundary View

### Module Boundaries

| Boundary         | Interface      | Stability    |
| ---------------- | -------------- | ------------ |
| Auth ↔ App      | AuthProvider   | Stable       |
| Auth ↔ Database | UserRepository | Stable       |
| Auth ↔ External | OAuthProvider  | Experimental |

### Extension Points

| Point          | Type     | How to Extend                    |
| -------------- | -------- | -------------------------------- |
| AuthProvider   | Strategy | Implement AuthProvider interface |
| TokenStrategy  | Strategy | Implement TokenStrategy          |
| UserRepository | Abstract | Implement for new data stores    |
| AuditHooks     | Observer | Subscribe to auth events         |

### Dependency Graph

[Dependency Diagram - Mermaid or ASCII]

### Stability Analysis

- **Stable Core**: AuthService, TokenManager (change rarely)
- **Variable Edge**: OAuthProviders (change often)
- **Recommendation**: Depend on abstractions, not implementations
```

### 5. Risk View

```markdown
## 5. Risk View

### Architectural Risks

| Risk                         | Severity | Likelihood | Mitigation                  |
| ---------------------------- | -------- | ---------- | --------------------------- |
| Single DB as auth bottleneck | High     | Medium     | Add read replicas, caching  |
| Token secret exposure        | Critical | Low        | HSM, key rotation           |
| Session fixation             | High     | Medium     | Regenerate session on login |

### Non-Risks (Sound Decisions)

- **JWT for stateless auth**: Well-established pattern, fits distributed architecture
- **Bcrypt for passwords**: Industry standard, configurable work factor
- **Separate auth service**: Clear boundary, independent scaling

### Technical Debt

| Item                   | Impact | Remediation Effort |
| ---------------------- | ------ | ------------------ |
| No rate limiting       | High   | Medium             |
| Hardcoded token expiry | Low    | Low                |
```

### 6. Trade-off View

```markdown
## 6. Trade-off View

### Decision: JWT vs Session-based Auth

**Context**: Need stateless auth for distributed system
**Decision**: Use JWT tokens
**Trade-off**: Token revocation complexity increased
**Quality Attributes**: Scalability ↑, Simplicity ↓
**Alternatives Considered**:

- Session with Redis: More control, but added infrastructure
- OAuth only: Delegates complexity, but less control

### Decision: Separate Auth Service

**Context**: Auth logic growing complex, needs independent scaling
**Decision**: Extract to separate service
**Trade-off**: Network latency added, operational complexity increased
**Quality Attributes**: Scalability ↑, Maintainability ↑, Complexity ↑

### Trade-off Matrix

| Decision           | Benefit             | Cost             |
| ------------------ | ------------------- | ---------------- |
| JWT tokens         | Stateless, scalable | Revocation hard  |
| Separate service   | Independent scaling | Network overhead |
| Abstract providers | Flexibility         | Indirection      |
```

### 7. Extensibility Guide

````markdown
## 7. Extensibility Guide

### How to Add OAuth Provider

1. Implement `OAuthProvider` interface:
   ```typescript
   interface OAuthProvider {
     getAuthUrl(): string;
     exchangeCode(code: string): Promise<UserInfo>;
   }
   ```
````

2. Register in `AuthProviderRegistry`
3. Add configuration in `auth.config.ts`

### How to Add MFA Support

1. Create `MFAStrategy` interface
2. Implement strategies (TOTP, SMS, Email)
3. Add MFA step to authentication flow
4. Store MFA secrets securely

### Safe vs Breaking Changes

**Safe Changes** (no migration needed):

- Add new OAuth provider
- Add new audit events
- Increase token expiry

**Breaking Changes** (requires migration):

- Change token format
- Modify UserRepository interface
- Change password hashing algorithm

````

## Tool Selection

Choose the right tool for each design step:

| Tool                   | Use When                                      |
| ---------------------- | --------------------------------------------- |
| **Grep**               | Finding patterns, interfaces, implementations |
| **Glob**               | Locating file structures, module boundaries   |
| **Read**               | Understanding component implementations       |
| **LSP goToDefinition** | Tracing interface definitions                 |
| **LSP findReferences** | Finding all implementations                   |
| **LSP incomingCalls**  | Understanding component dependencies          |

## Question Guidelines

### When to Use AskUserQuestion

Use the `AskUserQuestion` tool when:

- There are 2-4 clear design options
- User preference matters for architecture
- You need to validate a design assumption
- Trade-off decision needs user input

### Example AskUserQuestion Structures

**Design direction:**

```json
{
  "questions": [
    {
      "question": "What architectural style fits your needs?",
      "header": "Architecture",
      "options": [
        { "label": "Monolith", "description": "Simple, single deployment unit" },
        { "label": "Microservices", "description": "Independent, scalable services" },
        { "label": "Modular monolith", "description": "Single deployment, clear modules" }
      ],
      "multiSelect": false
    }
  ]
}
````

**Trade-off acceptance:**

```json
{
  "questions": [
    {
      "question": "The proposed design favors scalability over simplicity. Is this acceptable?",
      "header": "Trade-off",
      "options": [
        {
          "label": "Yes, scalability matters",
          "description": "Accept added complexity"
        },
        {
          "label": "Prefer simplicity",
          "description": "Keep it simple for now"
        },
        { "label": "Need more info", "description": "Explain the implications" }
      ],
      "multiSelect": false
    }
  ]
}
```

**Extension point confirmation:**

```json
{
  "questions": [
    {
      "question": "Which areas need extension points for future growth?",
      "header": "Extensibility",
      "options": [
        {
          "label": "Auth providers",
          "description": "Add new OAuth/SSO providers"
        },
        {
          "label": "Storage backends",
          "description": "Support different databases"
        },
        {
          "label": "Notification channels",
          "description": "Add email/SMS/push"
        },
        { "label": "All of the above", "description": "Maximum flexibility" }
      ],
      "multiSelect": true
    }
  ]
}
```

## Escape Hatches

If user wants design before reaching HIGH confidence:

```markdown
User: Just show me the design

You: Current confidence is 58/100 (SOLID). I can present the design now, but note these gaps:

### Preliminary Design

**Confidence Gaps:**

- Error flows not fully documented (may miss edge cases)
- Trade-offs not fully analyzed (some decisions may have hidden costs)

[Present design with "Preliminary" label on unvalidated sections]

| Section        | Confidence | Note                  |
| -------------- | ---------- | --------------------- |
| Context View   | High       | Validated             |
| Component View | High       | Validated             |
| Flow View      | Medium     | Happy path only       |
| Boundary View  | Low        | Extension points TBD  |
| Risk View      | Medium     | Main risks identified |
| Trade-off View | Low        | Needs more analysis   |

**Recommendation:** Continue analysis to reach HIGH confidence.
```

## Anti-Patterns to Avoid

**Don't:**

- Design without understanding the system first
- Skip the Walkthrough Protocol
- Present architecture before 80% confidence
- Ignore risks and trade-offs
- Create diagrams without explanation
- Make assumptions when you could ask
- Design in isolation without user feedback

**Do:**

- Use the Walkthrough Protocol before designing
- Show confidence metrics at every step
- Target lowest-scoring factors
- Use both Mermaid and ASCII diagrams
- Explore codebase to validate assumptions
- Document risks explicitly (ATAM style)
- Document trade-offs with rationale (ADR style)
- Keep iterating until HIGH confidence

## Integration with /plan

The output of `/design` can feed into `/plan`:

```markdown
User: "Create implementation plan from this design"

You: I'll use this architecture design as the basis for an implementation plan.

[Transition to /plan mode with design context]

The design provides:

- Component structure → Implementation order
- Interfaces → Files to create
- Extension points → Abstraction patterns
- Risks → Items to mitigate during implementation
```

## Iteration Loop

The design process is iterative:

```
1. Understand context → Ask questions → Confirm understanding
2. Explore code (Walkthrough) → Identify components → Ask questions
3. Map flows → Document boundaries → Ask about extension points
4. Analyze risks (ATAM) → Document trade-offs (ADR) → Ask about priorities
5. All thresholds met → Present design → Ask about next steps
6. User requests plan? → Transition to /plan with design context
```

Remember: **A high-confidence design prevents wasted implementation effort. Understand before you design.**
