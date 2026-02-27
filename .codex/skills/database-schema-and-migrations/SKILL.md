---
name: database-schema-and-migrations
description: Plan database schema evolution, migration rollout, backfills, and rollback. Use when introducing schema changes, data transformations, or compatibility-sensitive DB updates.
---

# Database Schema And Migrations

## Overview
Plan safe schema evolution with explicit rollout, verification, backfill, and rollback steps to avoid downtime and data corruption.

## Inputs
Collect:
- current schema and data volume profile
- application read/write paths affected
- downtime tolerance and deployment topology
- compliance and retention constraints

## Workflow
1. Define target schema and compatibility strategy.
2. Classify change type (`additive`, `transform`, `breaking`) and risk level.
3. Plan migration sequence for forward compatibility (expand -> migrate -> contract where needed).
4. Define backfill method, batching, throttling, and idempotency.
5. Define verification checks before and after rollout.
6. Define rollback strategy for schema and data paths.
7. Define operational runbook (commands, timing, owners).
8. Gate release on dry-run or staging validation.

## Deliverables
Produce:
- migration plan with ordered steps
- backfill plan and safety controls
- verification checklist with acceptance thresholds
- rollback plan with abort triggers

## Quality Bar
Accept the migration plan only when:
- rollout steps are reversible or safely forward-fixable
- backfill is idempotent and observable
- abort criteria are explicit
- ownership and timing are assigned

## Resources
- `references/migration-runbook-template.md`
