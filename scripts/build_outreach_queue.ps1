$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $PSScriptRoot
$schoolRoot = Join-Path $repoRoot 'school_packages'
$outDir = Join-Path $repoRoot 'private\outreach'
New-Item -ItemType Directory -Force -Path $outDir | Out-Null

function Get-FirstEmail {
    param([string]$Text)
    $match = [regex]::Match($Text, '[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}', 'IgnoreCase')
    if ($match.Success) { return $match.Value }
    return ''
}

function Get-Salutation {
    param([string]$Name, [string]$Role)
    $clean = $Name -replace '"', ''
    $clean = $clean -replace '\s+', ' '
    $surname = ($clean.Trim() -split '\s+')[-1]
    if ($clean -match 'Polo') { $surname = 'Chau' }
    if ($clean -match 'Khai N\. Truong') { $surname = 'Truong' }
    if ($clean -match 'Yan Tina Luximon') { $surname = 'Luximon' }
    if ($clean -match 'Danica Kragic') { $surname = 'Kragic' }
    if ($clean -match 'Karl') { $surname = 'Astrom' }
    if ($clean -match 'Oisin Mac Aodha') { $surname = 'Mac Aodha' }
    if ($clean -match 'Hani Ben Amor') { $surname = 'Ben Amor' }
    if ($clean -match 'Abdulmotaleb El Saddik') { $surname = 'El Saddik' }
    if ($Role -match 'Professor|Prof\.|Chair') { return "Professor $surname" }
    if ($Role -match 'Associate Professor') { return "Associate Professor $surname" }
    if ($Role -match 'Assistant Professor') { return "Professor $surname" }
    if ($Role -match 'Lecturer|Researcher|Fellow|Dr\.|Dr,|Dr ') { return "Dr $surname" }
    return "Professor $surname"
}

$preferredRecipients = @{
    'usa/carnegie_mellon_university' = 'Jeffrey P. Bigham'
}

$personalizationMap = @{
    'australia/monash_university' = 'I see a possible fit with your work in human-centred computing, information visualisation, explainable AI, and interactive systems because my proposed research needs human-in-the-loop explanation and assessment interfaces for age-friendly indoor spatial risk evaluation.'
    'australia/rmit_university' = 'I see a possible fit with your work in GeoAI, knowledge representation and reasoning, spatial data modelling, and qualitative spatial reasoning because my proposed research aims to build applied spatial intelligence methods for age-friendly built environment assessment.'
    'australia/university_of_sydney' = 'I see a possible fit with your work in HCI, ubiquitous computing, human-centred AI, mixed reality, and interactive systems because my proposed research focuses on human-AI workflows for age-friendly indoor safety and accessibility assessment.'
    'australia/unsw_sydney' = 'I see a possible fit with your work on multimodal machine learning, foundation models for spatio-temporal data, sensor-based behavioural modelling, and trustworthy ML because my proposed research connects indoor/community environment assessment with explainable spatial AI.'
    'canada/carleton_university' = 'I see a possible fit with your work on inclusive design of emerging technology, conversational and voice interfaces, virtual reality, and reducing technology-access barriers for older adults because my proposed research connects multimodal AI, spatial assessment, and human-centered decision support for aging-in-place environments.'
    'canada/mcgill_university' = 'I see a possible fit with your work on accessibility of computer systems, HCI, interactive technologies for older users and individuals with disabilities, and AI-enhanced services for active aging because my proposed research connects multimodal AI, spatial assessment, and human-centered decision support for aging-in-place environments.'
    'canada/university_of_ottawa' = 'I see a possible fit with your work on ambient interactive media, AI, computer vision, digital twins, VR/AR, haptics, immersive multimedia, and intelligent multimodal systems because my proposed research connects multimodal AI, spatial assessment, and human-centered decision support for aging-in-place environments.'
    'canada/university_of_toronto' = 'I see a possible fit with your work at the intersection of HCI and ubiquitous computing, especially health and assistive technologies for older adults and people with disabilities, because my proposed research connects multimodal AI, spatial assessment, and human-centered decision support for aging-in-place environments.'
    'canada/university_of_waterloo' = 'I see a possible fit with your work on user experience design, digital inclusion, aging, NLP, ethics, and voice/language-enabled interactive technologies for older adults because my proposed research connects multimodal AI, spatial assessment, and human-centered decision support for aging-in-place environments.'
    'canada/york_university' = 'I see a possible fit with your work at the intersection of HCI, AI, and UX, including human-AI collaborative tools and assistive technologies for diverse user communities, because my proposed research connects multimodal AI, spatial assessment, and human-centered decision support for aging-in-place environments.'
    'europe/aalto_university' = 'I see a possible fit with your work on HCI, user interfaces, human factors, interactive AI, computational design/modeling, and cognitive modeling for interactive and intelligent systems.'
    'europe/chalmers_university_of_technology' = 'I see a possible fit with your work on tangible/tabletop interaction, VR/AR, mobile computing, data visualization, social robotics, and interaction-centered systems.'
    'europe/eindhoven_university_of_technology' = 'I see a possible fit with your work on human-technology interaction, design for behavior change, human-centered assessment workflows, and design validation.'
    'europe/kth_royal_institute_of_technology' = 'I see a possible fit with your work on robotics, computer vision, machine learning, autonomous systems, and embodied perception for spatial AI.'
    'europe/linkoping_university' = 'I see a possible fit with your work on 3D computer vision, computational imaging, object detection, robot vision, and autonomous systems.'
    'europe/lund_university' = 'I see a possible fit with your work in computer vision and machine learning, especially visual and spatial AI methods.'
    'europe/saarland_university_dfki' = 'I see a possible fit with your work on Ambient Assisted Living, accessibility, AI in health, user-centred design, and human-computer interaction.'
    'europe/technical_university_of_munich' = 'I see a possible fit with your work on 3D AI, real-world 3D environments, semantic grounding, and reasoning about physical spaces.'
    'europe/tu_delft' = 'I see a possible fit with your work on Human-Centered Artificial Intelligence, human-AI interaction, trustworthy and socially beneficial systems, and AI-driven systems design.'
    'europe/university_of_amsterdam' = 'I see a possible fit with your work on vision-language models, video-text retrieval, VideoLLMs, object detection, activity recognition, and computer vision for public-space analysis.'
    'hong_kong/cityu' = 'I see a possible fit with your work on neural spatial computing, 3D geometry representation, computer vision, and 3D indoor assessment because my proposed research connects multimodal AI with age-friendly spatial risk evaluation.'
    'hong_kong/cuhk' = 'I see a possible fit with your work across 3D generation/design, 3D reconstruction, HCI, AR/VR, computer graphics, computer vision, visualization, and user interaction because my proposed research focuses on explainable age-friendly indoor spatial assessment.'
    'hong_kong/hku' = 'I see a possible fit with your work in computer vision, machine learning, deep learning, and safety-driven embodied AI for elderly care because my proposed research targets explainable multimodal assessment of age-friendly indoor environments.'
    'hong_kong/hkust' = 'I see a possible fit with your work on HCI, visualization, VR/AR, robotics, and data-driven human-engaged AI in health and design domains because my proposed research connects spatial assessment with human-AI decision support.'
    'hong_kong/polyu' = 'I see a possible fit with your work on ergonomic design, anthropometry, 3D human modeling, AI in design, HCI, and HRI because my proposed research focuses on AI-assisted age-friendly indoor design recommendation.'
    'new_zealand/university_of_auckland' = 'I see a possible fit with your work in AR/VR/XR, HCI, empathic computing, and 3D collaboration because my proposed research could develop an HCI-ready indoor spatial assessment system for age-friendly environments.'
    'new_zealand/university_of_canterbury' = 'I see a possible fit with your work on interactive health technologies, VR health interventions, user studies, and design engineering because my proposed research treats age-friendly indoor assessment as a validated health/HCI system.'
    'new_zealand/university_of_otago' = 'I see a possible fit with your work in HCI, virtual and augmented reality, presence, computer-mediated communication, and virtual rehabilitation because my proposed research focuses on human-centred AI support for healthy ageing indoor environments.'
    'new_zealand/university_of_waikato' = 'I see a possible fit with your work in lightweight machine learning, data mining, and interpretable applied modelling because my proposed research needs valid and explainable indoor risk-assessment models for age-friendly environments.'
    'new_zealand/victoria_university_of_wellington' = 'I see a possible fit with your work in explainable and interdisciplinary AI, AI for good, social and ethical AI, and health-equity AI because my proposed research requires explainable assessment and expert validation for age-friendly indoor environments.'
    'uk/ucl' = 'I see a possible fit with your work in interaction design, assistive technology, AI, disability innovation, and older people because my proposed research focuses on accessible AI tools for assessing indoor barriers and producing explainable design recommendations.'
    'uk/university_of_bristol' = 'I see a possible fit with your work connected to SPHERE, digital health, pervasive health, indoor localisation, elderly health monitoring, and decision support because my proposed research focuses on indoor/home assessment and aging-related AI decision support.'
    'uk/university_of_glasgow' = 'I see a possible fit with your work in responsible and interactive AI, HCI, long-term conditions, low vision, and teachable object recognisers because my proposed research develops explainable, human-centered AI assessment tools for accessible indoor environments.'
    'uk/university_of_nottingham' = 'I see a possible fit with your work in HCI, human-centred systems, ubiquitous computing, and the Mixed Reality Lab because my proposed research builds human-AI tools for spatial assessment, prototype evaluation, and expert validation.'
    'usa/arizona_state_university' = 'I see a possible fit with your work on robotics, human-robot interaction, assistive robotics, and deployable AI prototypes because my proposed research explores spatial AI support for age-friendly indoor assessment.'
    'usa/carnegie_mellon_university' = 'I see a possible fit with your work in accessibility, AI, and human-centered computing because my proposed research aims to develop accessibility-aware human-AI systems for indoor spatial assessment.'
    'usa/georgia_tech' = 'I see a possible fit with your work on human-centered AI, visual analytics, and explainable decision-support interfaces because my proposed research applies visual analytics to age-friendly spatial assessment.'
    'usa/northeastern_university' = 'I see a possible fit with your work in personal health informatics, sensing, behavioral interventions, and health-facing HCI because my proposed research focuses on aging-in-place and indoor health decision support.'
    'usa/uiuc' = 'I see a possible fit with your work on computer vision, scene understanding, 3D reasoning, and indoor-environment analysis because my proposed research focuses on explainable indoor fall-risk and accessibility assessment.'
    'usa/university_of_colorado_boulder' = 'I see a possible fit with your work on accessibility, HCI, assistive technology, and inclusive interaction design because my proposed research focuses on older adults'' home safety and accessible spatial assessment.'
    'usa/university_of_washington' = 'I see a possible fit with your work in accessibility-aware HCI and assistive technology because it is a strong bridge to my proposed human-AI systems research for disability and aging-in-place environments.'
}

function Get-SchoolName {
    param([string]$Package)
    $schoolMap = @{
        'australia/monash_university' = 'Monash University'
        'australia/rmit_university' = 'RMIT University'
        'australia/university_of_melbourne' = 'the University of Melbourne'
        'australia/university_of_sydney' = 'the University of Sydney'
        'australia/unsw_sydney' = 'UNSW Sydney'
        'canada/carleton_university' = 'Carleton University'
        'canada/mcgill_university' = 'McGill University'
        'canada/university_of_ottawa' = 'the University of Ottawa'
        'canada/university_of_toronto' = 'the University of Toronto'
        'canada/university_of_waterloo' = 'the University of Waterloo'
        'canada/york_university' = 'York University'
        'europe/aalto_university' = 'Aalto University'
        'europe/chalmers_university_of_technology' = 'Chalmers University of Technology'
        'europe/eindhoven_university_of_technology' = 'Eindhoven University of Technology'
        'europe/kth_royal_institute_of_technology' = 'KTH Royal Institute of Technology'
        'europe/linkoping_university' = 'Linkoping University'
        'europe/lund_university' = 'Lund University'
        'europe/saarland_university_dfki' = 'Saarland University / DFKI'
        'europe/technical_university_of_munich' = 'the Technical University of Munich'
        'europe/tu_delft' = 'TU Delft'
        'europe/university_of_amsterdam' = 'the University of Amsterdam'
        'hong_kong/cityu' = 'City University of Hong Kong'
        'hong_kong/cuhk' = 'the Chinese University of Hong Kong'
        'hong_kong/hku' = 'the University of Hong Kong'
        'hong_kong/hkust' = 'the Hong Kong University of Science and Technology'
        'hong_kong/polyu' = 'the Hong Kong Polytechnic University'
        'new_zealand/university_of_auckland' = 'the University of Auckland'
        'new_zealand/university_of_canterbury' = 'the University of Canterbury'
        'new_zealand/university_of_otago' = 'the University of Otago'
        'new_zealand/university_of_waikato' = 'the University of Waikato'
        'new_zealand/victoria_university_of_wellington' = 'Victoria University of Wellington'
        'uk/ucl' = 'UCL'
        'uk/university_of_bristol' = 'the University of Bristol'
        'uk/university_of_edinburgh' = 'the University of Edinburgh'
        'uk/university_of_glasgow' = 'the University of Glasgow'
        'uk/university_of_nottingham' = 'the University of Nottingham'
        'usa/arizona_state_university' = 'Arizona State University'
        'usa/carnegie_mellon_university' = 'Carnegie Mellon University'
        'usa/georgia_tech' = 'Georgia Tech'
        'usa/northeastern_university' = 'Northeastern University'
        'usa/uiuc' = 'the University of Illinois Urbana-Champaign'
        'usa/university_of_colorado_boulder' = 'the University of Colorado Boulder'
        'usa/university_of_washington' = 'the University of Washington'
    }
    if ($schoolMap.ContainsKey($Package)) { return $schoolMap[$Package] }
    $slug = ($Package -split '/')[-1]
    $parts = $slug -split '_'
    $textInfo = (Get-Culture).TextInfo
    return ($parts | ForEach-Object {
        switch ($_) {
            'ucl' { 'UCL'; break }
            'uiuc' { 'UIUC'; break }
            'hku' { 'HKU'; break }
            'hkust' { 'HKUST'; break }
            'cuhk' { 'CUHK'; break }
            'cityu' { 'CityU'; break }
            'polyu' { 'PolyU'; break }
            'unsw' { 'UNSW'; break }
            'rmit' { 'RMIT'; break }
            'dfki' { 'DFKI'; break }
            'tu' { 'TU'; break }
            default { $textInfo.ToTitleCase($_) }
        }
    }) -join ' '
}

function Get-Personalization {
    param([string]$Fit)
    $text = $Fit.Trim()
    $text = $text -replace '^(Very strong|Strong|Good|Medium|Direct|Useful|Relevant|Excellent|Current)\s+(replacement candidate\s+)?(fit|[A-Za-z /-]+fit)\s*(through|for|with|across)?\s*', ''
    $text = $text -replace '^Official profile (lists|states)\s*', ''
    $text = $text -replace '^Official [^:]+:\s*', ''
    $text = $text -replace '\s+', ' '
    $text = $text.Trim(' ', '.')
    if ($text.Length -gt 240) {
        $cut = $text.Substring(0, 240)
        $lastComma = $cut.LastIndexOf(',')
        $lastSemi = $cut.LastIndexOf(';')
        $lastStop = [Math]::Max($lastComma, $lastSemi)
        if ($lastStop -gt 100) { $cut = $cut.Substring(0, $lastStop) }
        $text = $cut.Trim(' ', ',', ';', '.')
    }
    if (-not $text) {
        $text = 'human-centered AI, spatial assessment, and interactive decision-support systems'
    }
    return "I see a possible fit with your work on $text. My proposed research would connect multimodal AI, spatial assessment, and human-centered decision support for aging-in-place environments."
}

function Get-ProjectTitle {
    param([string]$OutreachPath)
    $subject = ''
    if (Test-Path $OutreachPath) {
        $m = Select-String -Path $OutreachPath -Pattern '^Subject:\s*(.+)$' | Select-Object -First 1
        if ($m) { $subject = $m.Matches[0].Groups[1].Value.Trim() }
    }
    if ($subject -match 'Prospective PhD applicant:\s*(.+)$') {
        return $matches[1].Trim()
    }
    return 'Knowledge-Guided Spatial Intelligence for Age-Friendly Indoor Assessment'
}

function New-Body {
    param(
        [string]$Salutation,
        [string]$SchoolName,
        [string]$ProjectTitle,
        [string]$Personalization
    )
    return @"
Dear $Salutation,

My name is Wen Quan. I have completed a PhD in Interior Design at Universiti Sains Malaysia, with a research focus on age-friendly built environments, AI-assisted assessment, and spatial evaluation.

I am now seeking a second PhD in Computer Science / AI / HCI to move from domain-specific built environment research toward computational methods. For $SchoolName, I am particularly interested in a project on "$ProjectTitle".

My recent work includes published and under-review studies involving LSTM-based prediction, NLP/SciBERT-assisted framework development, contrastive learning, hyperbolic embedding, GANs, point-cloud analysis, meta-learning, and explainable AI. Two current AI/CS manuscripts are under review/revision processing in Neural Networks and Egyptian Informatics Journal. I also maintain a web-based portfolio demo:

https://wenquan0816.github.io/age-friendly-community-map/

$Personalization

Would you be open to considering a PhD applicant with my interdisciplinary background? I would be happy to send a short research concept note, CV, and portfolio.

Best regards,

Wen Quan
"@
}

$rows = @()
$packages = Get-ChildItem -Path $schoolRoot -Recurse -Filter 'target_supervisors.md' | Sort-Object FullName

foreach ($file in $packages) {
    $dir = Split-Path $file.FullName -Parent
    $package = $dir.Substring($schoolRoot.Length + 1).Replace('\', '/')
    $outreachPath = Join-Path $dir 'outreach_email.md'
    $projectTitle = Get-ProjectTitle $outreachPath
    $schoolName = Get-SchoolName $package
    $candidates = @()
    $chosen = $null

    foreach ($line in Get-Content $file.FullName) {
        if ($line -match '^\|\s*([^|]+?)\s*\|\s*([^|]+?)\s*\|\s*([^|]+?)\s*\|\s*([^|]+?)\s*\|\s*([^|]+?)\s*\|\s*([^|]+?)\s*\|\s*([^|]+?)\s*\|') {
            $name = $matches[1].Trim()
            $role = $matches[2].Trim()
            $fit = $matches[3].Trim()
            $emailField = $matches[5].Trim()
            $score = $matches[6].Trim()
            $notes = $matches[7].Trim()
            if ($name -eq 'Name') { continue }
            $email = Get-FirstEmail $emailField
            if (-not $email) { continue }
            if ($email -match 'firstname\.lastname|example\.com|not applicable|info@|aienq@') { continue }
            if ($score -match 'Low') { continue }
            $priority = 9
            if ($score -match '^High') { $priority = 1 }
            elseif ($score -match 'Medium-High') { $priority = 2 }
            elseif ($score -match '^Medium') { $priority = 3 }
            $candidates += [pscustomobject]@{
                Priority = $priority
                Name = $name
                Role = $role
                Fit = $fit
                Email = $email
                Score = $score
                Notes = $notes
            }
        }
    }

    $preferred = $preferredRecipients[$package]
    if ($preferred) {
        $chosen = $candidates | Where-Object { $_.Name -eq $preferred } | Select-Object -First 1
    }
    if (-not $chosen) {
        $chosen = $candidates | Sort-Object Priority | Select-Object -First 1
    }
    if (-not $chosen) {
        $rows += [pscustomobject]@{
            package = $package
            status = 'skip'
            name = ''
            email = ''
            subject = "Prospective PhD applicant: $projectTitle"
            reason = 'No high/medium-high candidate with a concrete personal email.'
            body = ''
        }
        continue
    }

    $salutation = Get-Salutation $chosen.Name $chosen.Role
    $personalization = $personalizationMap[$package]
    if (-not $personalization) {
        $personalization = Get-Personalization $chosen.Fit
    }
    $subject = "Prospective PhD applicant: $projectTitle"
    $body = New-Body $salutation $schoolName $projectTitle $personalization
    $status = 'send'
    $reason = 'Selected highest-fit candidate with concrete email.'

    if ($package -eq 'australia/university_of_melbourne' -and $chosen.Email -match 'sydney\.edu\.au') {
        $status = 'skip'
        $reason = 'Top candidate email belongs to University of Sydney, not University of Melbourne.'
    }
    if ($package -eq 'uk/university_of_edinburgh' -and $chosen.Email -match 'firstname\.lastname') {
        $status = 'skip'
        $reason = 'Email is a template address, not a concrete recipient.'
    }

    $rows += [pscustomobject]@{
        package = $package
        status = $status
        name = $chosen.Name
        email = $chosen.Email
        subject = $subject
        reason = $reason
        body = $body
    }
}

$jsonPath = Join-Path $outDir 'gmail_outreach_queue.json'
$csvPath = Join-Path $outDir 'gmail_outreach_queue.csv'
$rows | ConvertTo-Json -Depth 5 | Set-Content -Encoding UTF8 $jsonPath
$rows | Select-Object package,status,name,email,subject,reason | Export-Csv -NoTypeInformation -Encoding UTF8 $csvPath

$rows | Group-Object status | Select-Object Name,Count | Format-Table -AutoSize
Write-Host "Wrote $jsonPath"
Write-Host "Wrote $csvPath"
