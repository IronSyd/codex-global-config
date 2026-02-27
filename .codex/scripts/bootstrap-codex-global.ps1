param(
    [string]$RepoUrl,
    [string]$Branch = 'main',
    [string]$SourcePath,
    [string]$LocalRepoPath = "$HOME/.codex/global-codex-config",
    [switch]$RunPolicy = $true,
    [switch]$InstallDailyTask,
    [string]$TaskTime = '09:00'
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Copy-Dir {
    param(
        [Parameter(Mandatory=$true)][string]$From,
        [Parameter(Mandatory=$true)][string]$To
    )
    if (!(Test-Path $From)) { return }
    New-Item -ItemType Directory -Path $To -Force | Out-Null
    robocopy $From $To /E /NFL /NDL /NJH /NJS /NC /NS | Out-Null
}

$codexHome = "$HOME/.codex"
$skillsDest = Join-Path $codexHome 'skills'
$templatesDest = Join-Path $codexHome 'templates'
$scriptsDest = Join-Path $codexHome 'scripts'

$resolvedSource = $null

if ($SourcePath) {
    if (!(Test-Path $SourcePath)) {
        throw "SourcePath not found: $SourcePath"
    }
    $resolvedSource = (Resolve-Path $SourcePath).Path
}
elseif ($RepoUrl) {
    if (Test-Path $LocalRepoPath) {
        if (!(Test-Path (Join-Path $LocalRepoPath '.git'))) {
            throw "LocalRepoPath exists but is not a git repo: $LocalRepoPath"
        }
        Write-Output "Updating local config repo: $LocalRepoPath"
        git -C $LocalRepoPath fetch --all --prune
        git -C $LocalRepoPath checkout $Branch
        git -C $LocalRepoPath pull --ff-only origin $Branch
    }
    else {
        Write-Output "Cloning config repo to: $LocalRepoPath"
        git clone --branch $Branch $RepoUrl $LocalRepoPath
    }
    $resolvedSource = (Resolve-Path $LocalRepoPath).Path
}
else {
    throw "Provide either -SourcePath or -RepoUrl"
}

$layoutRoot = if (Test-Path (Join-Path $resolvedSource '.codex')) {
    Join-Path $resolvedSource '.codex'
} else {
    $resolvedSource
}

$skillsSource = Join-Path $layoutRoot 'skills'
$templatesSource = Join-Path $layoutRoot 'templates'
$scriptsSource = Join-Path $layoutRoot 'scripts'
$userAgentsSource = Join-Path $resolvedSource 'AGENTS.md'

if (!(Test-Path $skillsSource)) {
    throw "No skills directory found at source: $skillsSource"
}

New-Item -ItemType Directory -Path $skillsDest -Force | Out-Null
$skillFolders = Get-ChildItem -Path $skillsSource -Directory
foreach ($folder in $skillFolders) {
    if ($folder.Name -eq '.system') { continue }
    $target = Join-Path $skillsDest $folder.Name
    Write-Output "Sync skill: $($folder.Name)"
    Copy-Dir -From $folder.FullName -To $target
}

if (Test-Path $templatesSource) {
    Write-Output 'Sync templates'
    Copy-Dir -From $templatesSource -To $templatesDest
}

if (Test-Path $scriptsSource) {
    Write-Output 'Sync scripts'
    Copy-Dir -From $scriptsSource -To $scriptsDest
}

if (Test-Path $userAgentsSource) {
    Write-Output 'Sync user AGENTS.md'
    Copy-Item -Path $userAgentsSource -Destination (Join-Path $HOME 'AGENTS.md') -Force
}

$policyScript = Join-Path $scriptsDest 'apply-codex-policy.ps1'
if ($RunPolicy -and (Test-Path $policyScript)) {
    Write-Output 'Applying repo AGENTS policy'
    powershell -ExecutionPolicy Bypass -File $policyScript
}

if ($InstallDailyTask) {
    $taskName = 'CodexPolicyBootstrap'
    $bootstrapPath = Join-Path $scriptsDest 'bootstrap-codex-global.ps1'
    $cmd = "powershell -ExecutionPolicy Bypass -File `"$bootstrapPath`" -SourcePath `"$resolvedSource`" -RunPolicy"
    schtasks /Create /TN $taskName /SC DAILY /ST $TaskTime /TR $cmd /F | Out-Null
    Write-Output "Scheduled task '$taskName' set for $TaskTime"
}

Write-Output 'Bootstrap complete.'
Write-Output "Source: $resolvedSource"
Write-Output "Skills destination: $skillsDest"
Write-Output 'Restart Codex to pick up new or updated skills.'
