# Codex Global Config Bundle

This bundle is intended for syncing Codex skills and policy across devices.

## Structure
- .codex/skills (all non-system skills)
- .codex/templates
- .codex/scripts
- AGENTS.md (optional user-level default policy)

## AGENTS skill exposure
`apply-codex-policy.ps1` now injects a generated `## Skills` section into each repo's `AGENTS.md`.
The list is sourced from local `~/.codex/skills` (excluding `.system`) and refreshed on each policy apply.

## Apply on another machine
`powershell
powershell -ExecutionPolicy Bypass -File "C:\Users\Michael Alkali/.codex/scripts/bootstrap-codex-global.ps1" -SourcePath "<path-to-this-bundle>" -RunPolicy
`

## Apply from a Git repo
`powershell
powershell -ExecutionPolicy Bypass -File "C:\Users\Michael Alkali/.codex/scripts/bootstrap-codex-global.ps1" -RepoUrl "https://github.com/<you>/<repo>.git" -Branch main -RunPolicy
`

After sync: restart Codex.
