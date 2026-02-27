param(
    [string[]]$Roots = @('C:/Users/Michael Alkali'),
    [string]$TemplatePath = 'C:/Users/Michael Alkali/.codex/templates/AGENTS.repo-template.md',
    [string]$IgnoreFile = 'C:/Users/Michael Alkali/.codex/scripts/apply-codex-policy.ignore',
    [string]$SkillsRoot = "$HOME/.codex/skills",
    [switch]$IncludeRootsAsTargets
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Get-SkillDescription {
    param(
        [Parameter(Mandatory = $true)][string]$SkillMdPath
    )

    if (!(Test-Path $SkillMdPath)) {
        return "No description provided."
    }

    $raw = Get-Content -Path $SkillMdPath -Raw
    if ([string]::IsNullOrWhiteSpace($raw)) {
        return "No description provided."
    }

    $description = $null
    $lines = $raw -split "`r?`n"
    $index = 0

    if ($lines.Count -gt 0 -and $lines[0].Trim() -eq '---') {
        $index = 1
        while ($index -lt $lines.Count) {
            $line = $lines[$index].Trim()
            if ($line -eq '---') {
                $index += 1
                break
            }
            if ($line -match '^(?i)description\s*:\s*(.+)$') {
                $description = $Matches[1].Trim().Trim('"').Trim("'")
            }
            $index += 1
        }
    }

    if (![string]::IsNullOrWhiteSpace($description)) {
        return $description
    }

    for ($i = $index; $i -lt $lines.Count; $i += 1) {
        $trimmed = $lines[$i].Trim()
        if ([string]::IsNullOrWhiteSpace($trimmed)) { continue }
        if ($trimmed.StartsWith('#')) { continue }
        if ($trimmed.StartsWith('```')) { continue }
        if ($trimmed.StartsWith('---')) { continue }
        if ($trimmed.StartsWith('>')) { continue }
        if ($trimmed.StartsWith('|')) { continue }
        if ($trimmed -match '^[\-\*\d]+\.\s*$') { continue }

        return $trimmed
    }

    return "No description provided."
}

function Get-InstalledSkills {
    param(
        [Parameter(Mandatory = $true)][string]$SkillsRootPath
    )

    if (!(Test-Path $SkillsRootPath)) {
        return @()
    }

    $skills = @()
    $directories = Get-ChildItem -Path $SkillsRootPath -Directory -ErrorAction SilentlyContinue |
        Where-Object { $_.Name -ne '.system' } |
        Sort-Object Name

    foreach ($directory in $directories) {
        $skillMd = Join-Path $directory.FullName 'SKILL.md'
        if (!(Test-Path $skillMd)) { continue }

        $skills += [PSCustomObject]@{
            Name = $directory.Name
            SkillMdPath = (Resolve-Path $skillMd).Path
            Description = Get-SkillDescription -SkillMdPath $skillMd
        }
    }

    return $skills
}

function Render-AutoSkillsList {
    param(
        [Parameter(Mandatory = $true)][string]$SkillsRootPath
    )

    $skills = Get-InstalledSkills -SkillsRootPath $SkillsRootPath
    if ($skills.Count -eq 0) {
        return "- (none found under $SkillsRootPath)"
    }

    $items = @()
    foreach ($skill in $skills) {
        $path = $skill.SkillMdPath.Replace('\', '/')
        $description = [string]$skill.Description
        $items += "- $($skill.Name): $description (file: $path)"
    }

    return ($items -join "`r`n")
}

function Normalize-LineEndings {
    param(
        [AllowNull()][string]$Text
    )

    if ($null -eq $Text) {
        return ''
    }

    $normalized = $Text.Replace("`r`n", "`n").Replace("`r", "`n")
    $normalized = $normalized.TrimStart([char]0xFEFF)
    return $normalized.TrimEnd("`n")
}

if (!(Test-Path $TemplatePath)) {
    throw "Template not found: $TemplatePath"
}

$templateContent = Get-Content -Path $TemplatePath -Raw
$autoSkillsList = Render-AutoSkillsList -SkillsRootPath $SkillsRoot
$renderedTemplate = $templateContent.Replace('{{AUTO_SKILLS_LIST}}', $autoSkillsList)

$ignoreSet = New-Object 'System.Collections.Generic.HashSet[string]' ([System.StringComparer]::OrdinalIgnoreCase)
if (Test-Path $IgnoreFile) {
    Get-Content -Path $IgnoreFile | ForEach-Object {
        $line = $_.Trim()
        if ($line -and -not $line.StartsWith('#')) {
            [void]$ignoreSet.Add($line.Replace('\\','/'))
        }
    }
}

$repos = @()
foreach ($root in $Roots) {
    if (!(Test-Path $root)) { continue }
    $resolvedRoot = (Resolve-Path $root).Path
    if ($IncludeRootsAsTargets) {
        $repos += Get-Item -Path $resolvedRoot
    }
    $repos += Get-ChildItem -Path $resolvedRoot -Directory -Recurse -ErrorAction SilentlyContinue |
        Where-Object { Test-Path (Join-Path $_.FullName '.git') }
}

$repos = @($repos | Sort-Object FullName -Unique)

$updated = @()
$unchanged = @()
$skipped = @()
$errors = @()

foreach ($repo in $repos) {
    $repoPathNorm = $repo.FullName.Replace('\\','/')
    if ($ignoreSet.Contains($repoPathNorm)) {
        $skipped += $repo.FullName
        continue
    }

    $target = Join-Path $repo.FullName 'AGENTS.md'
    try {
        $needsUpdate = $true
        if (Test-Path $target) {
            $current = Get-Content -Path $target -Raw
            if ((Normalize-LineEndings $current) -eq (Normalize-LineEndings $renderedTemplate)) {
                $needsUpdate = $false
            }
        }

        if ($needsUpdate) {
            Set-Content -Path $target -Value $renderedTemplate
            $updated += $repo.FullName
        } else {
            $unchanged += $repo.FullName
        }
    }
    catch {
        $errors += "{0}: {1}" -f $repo.FullName, $_.Exception.Message
    }
}

Write-Output "Codex policy application summary"
Write-Output "Repos found: $($repos.Count)"
Write-Output "Updated: $($updated.Count)"
Write-Output "Unchanged: $($unchanged.Count)"
Write-Output "Skipped: $($skipped.Count)"
Write-Output "Errors: $($errors.Count)"

if ($updated.Count -gt 0) {
    Write-Output "`nUpdated repos:"
    $updated | ForEach-Object { Write-Output "- $_" }
}
if ($unchanged.Count -gt 0) {
    Write-Output "`nUnchanged repos:"
    $unchanged | ForEach-Object { Write-Output "- $_" }
}
if ($skipped.Count -gt 0) {
    Write-Output "`nSkipped repos:"
    $skipped | ForEach-Object { Write-Output "- $_" }
}
if ($errors.Count -gt 0) {
    Write-Output "`nErrors:"
    $errors | ForEach-Object { Write-Output "- $_" }
    exit 1
}
