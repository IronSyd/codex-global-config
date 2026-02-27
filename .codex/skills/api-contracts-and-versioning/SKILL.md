---
name: api-contracts-and-versioning
description: Define and review API contracts, compatibility rules, and versioning strategy. Use when creating new endpoints, changing request/response schemas, or planning deprecations.
---

# API Contracts And Versioning

## Overview
Create stable, explicit API contracts with clear compatibility rules so clients can integrate safely and changes can ship without regressions.

## Inputs
Collect:
- client types and integration patterns
- existing API conventions and auth model
- expected traffic, latency targets, and error budget
- backward compatibility requirements

## Workflow
1. Define resources and endpoint responsibilities.
2. Specify request and response schemas with required/optional fields.
3. Define error model (codes, messages, retryability, remediation hints).
4. Define auth, authorization, idempotency, pagination, and rate-limit behavior.
5. Define compatibility policy (additive vs breaking changes).
6. Define versioning and deprecation process (notice window, migration guidance).
7. Produce change log entries for all contract changes.
8. Validate examples against real use cases before sign-off.

## Deliverables
Produce:
- API contract spec (OpenAPI or equivalent)
- compatibility and versioning policy
- deprecation/migration notes where applicable
- endpoint-level examples and error matrix

## Quality Bar
Accept the API contract only when:
- all fields and error behaviors are unambiguous
- compatibility impact is classified for every change
- migration path exists for deprecated behavior
- at least one client scenario validates each endpoint

## Resources
- `references/contract-checklist.md`
