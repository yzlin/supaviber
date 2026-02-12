# AGENTS.md

## Agent Protocol

- "Make a note" => edit AGENTS.md (shortcut; not a blocker). Ignore `CLAUDE.md`.
- No `./runner`. Guardrails: use `trash` for deletes.
- Keep files <~500 LOC; split/refactor as needed.
- Bugs: add regression test when it fits.
- Commits: Conventional Commits (`feat|fix|refactor|build|ci|chore|docs|style|perf|test`).
- Editor: `zed <path>`.
- Prefer end-to-end verify; if blocked, say what’s missing.
- Style: telegraph. Drop filler/grammar. Min tokens (global AGENTS + replies).
- Smallest change that solves task; no drive-by refactors
- Prefer existing patterns over new abstractions

## Docs

- Start: run docs list (`docs-list` here if present; ignore if not installed); open docs before coding.
- Follow links until domain makes sense.
- Keep notes short; update docs when behavior/API changes (no ship w/o docs).
- Add `read_when` hints on cross-cutting docs.

## Critical Thinking

- Fix root cause (not band-aid).
- Unsure: read more code; if still stuck, ask w/ short options.
- Conflicts: call out; pick safer path.
- Unrecognized changes: assume other agent; keep going; focus your changes. If it causes issues, stop + ask user.
- Leave breadcrumb notes in thread.

## Required Diagrams

For every architectural assessment, you must create the following diagrams using Mermaid syntax:

### 1. System Context Diagram

- Show the system boundary
- Identify all external actors (users, systems, services)
- Show high-level interactions between the system and external entities
- Provide clear explanation of the system's place in the broader ecosystem

### 2. Component Diagram

- Identify all major components/modules
- Show component relationships and dependencies
- Include component responsibilities
- Highlight communication patterns between components
- Explain the purpose and responsibility of each component

### 3. Deployment Diagram

- Show the physical/logical deployment architecture
- Include infrastructure components (servers, containers, databases, queues, etc.)
- Specify deployment environments (dev, staging, production)
- Show network boundaries and security zones
- Explain deployment strategy and infrastructure choices

### 4. Data Flow Diagram

- Illustrate how data moves through the system
- Show data stores and data transformations
- Identify data sources and sinks
- Include data validation and processing points
- Explain data handling, transformation, and storage strategies

### 5. Sequence Diagram

- Show key user journeys or system workflows
- Illustrate interaction sequences between components
- Include timing and ordering of operations
- Show request/response flows
- Explain the flow of operations for critical use cases

### 6. Other Relevant Diagrams (as needed)

Based on the specific requirements, include additional diagrams such as:

- Entity Relationship Diagrams (ERD) for data models
- State diagrams for complex stateful components
- Network diagrams for complex networking requirements
- Security architecture diagrams
- Integration architecture diagrams

## Comment Policy

### Unacceptable Comments

- Comments that repeat what code does
- Commented-out code (delete it)
- Obvious comments ("increment counter")
- Comments instead of good naming
- Comments about updates to old code ("<- now supports xyz")

### Principle

Code should be self-documenting. If you need a comment to explain WHAT the code does, consider refactoring
to make it clearer.

## Tools

### trash

- Move files to Trash: `trash …` (system command).
