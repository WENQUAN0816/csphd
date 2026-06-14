$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $PSScriptRoot
$queuePath = Join-Path $repoRoot 'private\outreach\malaysia_ready_to_send_queue.json'
$logPath = Join-Path $repoRoot 'private\outreach\gmail_send_log.csv'

if (-not (Test-Path $queuePath)) {
    throw "Queue not found: $queuePath. Run scripts\generate_malaysia_school_packages.ps1 first."
}

$queue = Get-Content $queuePath -Raw | ConvertFrom-Json

$queue | ForEach-Object {
    [pscustomobject]@{
        package = $_.package
        status = $_.status
        name = $_.name
        email = $_.email
        subject = $_.subject
    }
} | Format-Table -AutoSize

Write-Host ''
Write-Host 'This script is a safety wrapper. Send emails through Gmail Direct MCP from Codex after reviewing the queue.'
Write-Host 'After each confirmed send, append a row to:'
Write-Host $logPath
Write-Host ''
Write-Host 'CSV columns required by generate_phd_status_site.ps1: timestamp,package,name,email,subject,status,message_id'
