---
name: project-specification
description: Force decision-complete planning before any mutating implementation work. Use for all coding tasks that could modify files, schemas, configs, migrations, infrastructure, deployments, or runtime behavior.
---

# Project Specification

## Overview
Produce a complete implementation specification before any mutating action. Do not edit files, apply patches, run migrations, or execute side-effectful deployment actions until the plan is decision complete and approved.

## Hard Gate Rules
1. Treat any request that can change repo-tracked state as mutating work.
2. Before mutating work, produce a decision-complete plan using `references/plan-template.md`.
3. If ambiguity remains, ask clarifying questions before planning finalization.
4. Start implementation only after the plan is locked.

## Required Planning Sequence
1. Ground in repository context first (readme, package manifests, entrypoints, schema/migrations, tests, deployment files).
2. Define objective, scope boundaries, constraints, and success criteria.
3. Specify interfaces and compatibility impacts (API/schema/config/CLI/UX).
4. Specify data flow, failure modes, and edge cases.
5. Specify testing matrix and acceptance criteria.
6. Specify rollout, observability, and rollback path.

## Plan Completion Criteria
A plan is complete only if:
- no high-impact decisions are deferred to implementer judgment
- all public interface changes are explicit
- compatibility/migration implications are explicit
- tests and acceptance criteria are executable and measurable
- rollout and rollback are explicit and owned

## Output Contract
When producing the final plan, include:
- clear title
- brief summary
- important changes to public APIs/interfaces/types
- test cases and scenarios
- explicit assumptions and defaults

## Resources
- `references/plan-template.md`
