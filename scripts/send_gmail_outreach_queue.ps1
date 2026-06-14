param(
    [string]$QueuePath = '',
    [string]$TokenPath = 'C:\Users\Administrator\.codex\secrets\gmail-token.json',
    [string]$LogPath = '',
    [int]$Limit = 0,
    [int]$DelaySeconds = 6,
    [switch]$DryRun
)

$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $PSScriptRoot
if (-not $QueuePath) {
    $QueuePath = Join-Path $repoRoot 'private\outreach\gmail_outreach_queue.json'
}
if (-not $LogPath) {
    $LogPath = Join-Path $repoRoot 'private\outreach\gmail_send_log.csv'
}

function ConvertTo-Base64Url {
    param([string]$Text)
    $bytes = [Text.Encoding]::UTF8.GetBytes($Text)
    return [Convert]::ToBase64String($bytes).Replace('+', '-').Replace('/', '_').TrimEnd('=')
}

function Clean-Header {
    param([string]$Value)
    if ($null -eq $Value) { return '' }
    return (($Value) -replace "\r?\n", ' ').Trim()
}

function New-RawMessage {
    param(
        [string]$To,
        [string]$Subject,
        [string]$Body
    )
    $toHeader = Clean-Header $To
    $subjectHeader = Clean-Header $Subject
    $mime = @(
        "To: $toHeader",
        "Subject: $subjectHeader",
        'MIME-Version: 1.0',
        'Content-Type: text/plain; charset="UTF-8"',
        'Content-Transfer-Encoding: 8bit',
        '',
        $Body
    ) -join "`r`n"
    return ConvertTo-Base64Url $mime
}

function Get-AccessToken {
    param([string]$Path)
    $token = Get-Content $Path -Raw | ConvertFrom-Json
    foreach ($key in @('client_id', 'client_secret', 'token_uri', 'refresh_token')) {
        if (-not $token.$key) {
            throw "Gmail token file is missing $key."
        }
    }
    $response = Invoke-RestMethod -Method Post -Uri $token.token_uri -ContentType 'application/x-www-form-urlencoded' -Body @{
        client_id = $token.client_id
        client_secret = $token.client_secret
        refresh_token = $token.refresh_token
        grant_type = 'refresh_token'
    }
    if (-not $response.access_token) {
        throw 'Could not refresh Gmail access token.'
    }
    return $response.access_token
}

function Read-SentKeys {
    param([string]$Path)
    $keys = @{}
    if (Test-Path $Path) {
        Import-Csv $Path | Where-Object { $_.status -eq 'sent' -and $_.message_id } | ForEach-Object {
            $keys["$($_.package)|$($_.email)|$($_.subject)"] = $true
        }
    }
    return $keys
}

function Append-Log {
    param(
        [string]$Path,
        [pscustomobject]$Entry
    )
    $exists = Test-Path $Path
    $Entry | Export-Csv -Path $Path -Append -NoTypeInformation -Encoding UTF8
}

if (-not (Test-Path $QueuePath)) {
    throw "Queue not found: $QueuePath"
}
if (-not (Test-Path $TokenPath)) {
    throw "Gmail token not found: $TokenPath"
}

$queue = Get-Content $QueuePath -Raw | ConvertFrom-Json
$items = @($queue | Where-Object { $_.status -eq 'send' -and $_.email -and $_.subject -and $_.body })
$sentKeys = Read-SentKeys $LogPath
$pending = @($items | Where-Object { -not $sentKeys.ContainsKey("$($_.package)|$($_.email)|$($_.subject)") })

if ($Limit -gt 0) {
    $pending = @($pending | Select-Object -First $Limit)
}

Write-Host "pending=$($pending.Count) dry_run=$DryRun"
if ($pending.Count -eq 0) { return }

$accessToken = $null
if (-not $DryRun) {
    $accessToken = Get-AccessToken $TokenPath
}

$sentCount = 0
foreach ($item in $pending) {
    $status = if ($DryRun) { 'dry_run' } else { 'sent' }
    $messageId = ''
    $errorText = ''
    try {
        if ($DryRun) {
            Write-Host "DRY $($item.package) -> $($item.email)"
        } else {
            $raw = New-RawMessage -To $item.email -Subject $item.subject -Body $item.body
            $response = Invoke-RestMethod `
                -Method Post `
                -Uri 'https://gmail.googleapis.com/gmail/v1/users/me/messages/send' `
                -Headers @{ Authorization = "Bearer $accessToken" } `
                -ContentType 'application/json; charset=utf-8' `
                -Body (@{ raw = $raw } | ConvertTo-Json -Compress)
            $messageId = $response.id
            Write-Host "SENT $($item.package) -> $($item.email) id=$messageId"
        }
        $sentCount += 1
    } catch {
        $status = 'failed'
        $errorText = $_.Exception.Message
        Write-Host "FAILED $($item.package) -> $($item.email): $errorText"
    }

    if (-not $DryRun) {
        Append-Log $LogPath ([pscustomobject]@{
            timestamp = (Get-Date).ToString('s')
            package = $item.package
            name = $item.name
            email = $item.email
            subject = $item.subject
            status = $status
            message_id = $messageId
            error = $errorText
        })
    }

    if (-not $DryRun -and $DelaySeconds -gt 0 -and $sentCount -lt $pending.Count) {
        Start-Sleep -Seconds $DelaySeconds
    }
}

Write-Host "processed=$sentCount log=$LogPath"
