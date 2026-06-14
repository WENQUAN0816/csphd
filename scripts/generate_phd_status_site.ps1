$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $PSScriptRoot
$schoolRoot = Join-Path $repoRoot 'school_packages'
$outPath = Join-Path $repoRoot 'phd_applications.json'
$sendLogPath = Join-Path $repoRoot 'private\outreach\gmail_send_log.csv'

function Get-LineValue {
    param(
        [string]$Text,
        [string]$Label
    )
    $pattern = "(?m)^- $([regex]::Escape($Label)):\s*(.+)$"
    $match = [regex]::Match($Text, $pattern)
    if ($match.Success) { return $match.Groups[1].Value.Trim() }
    return ''
}

function Get-WorkingTitle {
    param([string]$Text)
    $match = [regex]::Match($Text, '(?m)^\*\*Working title:\*\*\s*(.+)$')
    if ($match.Success) { return $match.Groups[1].Value.Trim() }
    return ''
}

function Get-SchoolName {
    param([string]$Text)
    $match = [regex]::Match($Text, '(?m)^#\s+(.+?)\s+PhD Application Package\s*$')
    if ($match.Success) { return $match.Groups[1].Value.Trim() }
    return ''
}

function Get-Track {
    param([string]$Region)
    switch ($Region) {
        'canada' { return 'Funded PhD + immigration track' }
        'new_zealand' { return 'Low-tuition PhD + scholarship track' }
        'hong_kong' { return 'HKPFS / university studentship track' }
        'europe' { return 'Paid doctoral position / funded project track' }
        'australia' { return 'RTP / scholarship track' }
        'malaysia' { return 'Malaysia supervisor-first PhD track' }
        'usa' { return 'Fully funded PhD track' }
        'uk' { return 'Studentship / scholarship track' }
        default { return 'Supervisor-first PhD track' }
    }
}

function Get-RegionLabel {
    param([string]$Region)
    switch ($Region) {
        'australia' { return '澳大利亚' }
        'canada' { return '加拿大' }
        'europe' { return '欧洲' }
        'hong_kong' { return '香港' }
        'malaysia' { return '马来西亚' }
        'new_zealand' { return '新西兰' }
        'uk' { return '英国' }
        'usa' { return '美国' }
        default { return $Region }
    }
}

function Get-DirectionCluster {
    param([string]$Title)
    if ($Title -match 'VLM|Vision-Language|Computer Vision|3D|Scene|Spatial Reasoning') {
        return 'Vision and spatial intelligence'
    }
    if ($Title -match 'HCI|Human-Centered|Human-AI|Interactive|Accessibility|Mixed-Reality') {
        return 'Human-centered AI and accessibility'
    }
    if ($Title -match 'Health|Aging|Sensing|Digital Health') {
        return 'Health and aging-in-place AI'
    }
    return 'Spatial AI for age-friendly environments'
}

function Get-PrimarySupervisor {
    param(
        [string]$Package,
        [hashtable]$SentMap,
        [string]$TargetPath
    )
    if ($SentMap.ContainsKey($Package)) {
        return $SentMap[$Package].name
    }
    if (-not (Test-Path $TargetPath)) { return '' }
    foreach ($line in Get-Content $TargetPath) {
        if ($line -match '^\|\s*([^|]+?)\s*\|\s*([^|]+?)\s*\|\s*([^|]+?)\s*\|\s*([^|]+?)\s*\|\s*([^|]+?)\s*\|\s*([^|]+?)\s*\|') {
            $name = $matches[1].Trim()
            $score = $matches[6].Trim()
            if ($name -ne 'Name' -and $name -notmatch '^-+$' -and $score -notmatch 'Low') {
                return $name
            }
        }
    }
    return ''
}

function Get-PriorityRank {
    param([string]$Priority)
    switch ($Priority) {
        'S' { return 1 }
        'A' { return 2 }
        'A-' { return 3 }
        'B+' { return 4 }
        'B' { return 5 }
        default { return 9 }
    }
}

function Get-AttachmentStatus {
    param([string]$PackageDir)
    $attachments = Join-Path $PackageDir 'attachments'
    $required = @(
        'Tailored_CV_Profile.md',
        'Tailored_RCN.md',
        'Tailored_RP_Abstract.md',
        'Tailored_Portfolio_Statement.md'
    )
    $ready = 0
    foreach ($file in $required) {
        if (Test-Path (Join-Path $attachments $file)) { $ready += 1 }
    }
    if ($ready -eq $required.Count) { return 'Draft tailored materials ready' }
    if ($ready -gt 0) { return "Partial drafts ready ($ready/$($required.Count))" }
    return 'Materials not prepared'
}

$sentMap = @{}
if (Test-Path $sendLogPath) {
    Import-Csv $sendLogPath | Where-Object { $_.status -eq 'sent' -and $_.message_id } | ForEach-Object {
        $sentMap[$_.package] = [pscustomobject]@{
            name = $_.name
            date = ([datetime]$_.timestamp).ToString('yyyy-MM-dd')
        }
    }
}

$apps = @()
$readmes = Get-ChildItem -Path $schoolRoot -Recurse -Filter 'README.md' |
    Where-Object { $_.FullName -notmatch '\\attachments\\' -and $_.DirectoryName -ne $schoolRoot } |
    Sort-Object FullName

foreach ($readme in $readmes) {
    $dir = $readme.DirectoryName
    $package = $dir.Substring($schoolRoot.Length + 1).Replace('\', '/')
    $text = Get-Content $readme.FullName -Raw
    $region = Get-LineValue $text 'Region'
    $school = Get-SchoolName $text
    $program = Get-LineValue $text 'Program target'
    $priority = Get-LineValue $text 'Priority level'
    $funding = Get-LineValue $text 'Funding route'
    $immigration = Get-LineValue $text 'Immigration route'
    $currentAction = Get-LineValue $text 'Current action'
    $title = Get-WorkingTitle $text
    $sent = $sentMap.ContainsKey($package)
    $targetPath = Join-Path $dir 'target_supervisors.md'
    $supervisor = Get-PrimarySupervisor $package $sentMap $targetPath
    $materialStatus = Get-AttachmentStatus $dir

    $stage = if ($sent) { 'First outreach sent' } else { 'Needs verified contact before outreach' }
    $result = if ($sent) { 'Awaiting response' } else { 'Not started' }
    $nextAction = if ($sent) {
        'Monitor reply; if positive, send CV, RCN, RP, and confirm funding route.'
    } else {
        'Verify a current supervisor email and send a tailored first outreach email.'
    }

    $apps += [pscustomobject]@{
        id = $package.Replace('/', '__')
        package = $package
        region = $region
        region_label = Get-RegionLabel $region
        school = $school
        priority = $priority
        priority_rank = Get-PriorityRank $priority
        program_target = $program
        track = Get-Track $region
        research_direction = $title
        direction_cluster = Get-DirectionCluster $title
        primary_supervisor = $supervisor
        first_outreach_status = if ($sent) { 'Sent' } else { 'Not sent' }
        first_outreach_date = if ($sent) { $sentMap[$package].date } else { '' }
        formal_application_status = 'Not submitted'
        formal_application_date = ''
        funding_status = 'Not confirmed'
        funding_route = $funding
        immigration_route = $immigration
        material_status = $materialStatus
        current_stage = $stage
        result = $result
        next_action = $nextAction
        current_action_from_package = $currentAction
        response_date = ''
        interview_status = 'Not started'
        offer_status = 'No offer yet'
        public_notes = if ($sent) {
            'Initial supervisor outreach has been sent. Waiting for reply before formal application.'
        } else {
            'Paused because a safe public supervisor contact still needs verification.'
        }
        updated_at = (Get-Date).ToString('yyyy-MM-dd')
    }
}

$payload = [pscustomobject]@{
    metadata = [pscustomobject]@{
        title = 'Wen Quan 博士申请进度追踪'
        owner = 'Wen Quan'
        research_positioning = '知识引导的视觉语言模型与轻量化空间智能，用于适老化室内空间评估和设计建议。'
        generated_at = (Get-Date).ToString('yyyy-MM-ddTHH:mm:ssK')
        public_data_notice = '公开进度页不包含导师邮箱、私人文件、API 标识符和内部备注。'
    }
    applications = @($apps | Sort-Object priority_rank, region, school)
}

$payload | ConvertTo-Json -Depth 8 | Set-Content -Encoding UTF8 $outPath
Write-Host "Wrote $outPath"
Write-Host "applications=$($apps.Count)"
