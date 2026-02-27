param(
    [string[]]$Roots = @('C:/Users/Michael Alkali'),
    [string]$TemplatePath = 'C:/Users/Michael Alkali/.codex/templates/AGENTS.repo-template.md',
    [string]$IgnoreFile = 'C:/Users/Michael Alkali/.codex/scripts/apply-codex-policy.ignore'
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

if (!(Test-Path $TemplatePath)) {
    throw "Template not found: $TemplatePath"
}

$templateContent = Get-Content -Path $TemplatePath -Raw

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
    $repos += Get-ChildItem -Path $root -Directory -Recurse -ErrorAction SilentlyContinue |
        Where-Object { Test-Path (Join-Path $_.FullName '.git') }
}

$repos = $repos | Sort-Object FullName -Unique

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
            if ($current -eq $templateContent) {
                $needsUpdate = $false
            }
        }

        if ($needsUpdate) {
            Set-Content -Path $target -Value $templateContent
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
