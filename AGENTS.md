# Codex Global SDLC Policy

This default policy applies when a repository does not provide a repo-root `AGENTS.md`.

1. For mutating tasks, produce a decision-complete plan before implementation.
2. Invoke `project-specification` for implementation planning.
3. Ground plans in local repository context first.
4. Do not mutate files before plan lock.
5. After implementation, run relevant check/build/tests.
