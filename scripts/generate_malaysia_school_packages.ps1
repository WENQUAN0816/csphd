$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $PSScriptRoot
$schoolRoot = Join-Path $repoRoot 'school_packages'
$privateOutreach = Join-Path $repoRoot 'private\outreach'
New-Item -ItemType Directory -Force -Path $privateOutreach | Out-Null

function New-MalaysiaPackage {
    param(
        [string]$Slug,
        [string]$School,
        [string]$Priority,
        [string]$Program,
        [string]$Funding,
        [string]$Immigration,
        [string]$Title,
        [string]$Why,
        [string]$Angle,
        [array]$Supervisors,
        [string]$SelectedSupervisor,
        [string]$SelectedEmail,
        [string]$SelectedSource,
        [string]$SelectedEvidence,
        [string]$Personalization
    )

    $dir = Join-Path (Join-Path $schoolRoot 'malaysia') $Slug
    $attach = Join-Path $dir 'attachments'
    New-Item -ItemType Directory -Force -Path $attach | Out-Null

    $supervisorRows = @()
    foreach ($s in $Supervisors) {
        $supervisorRows += "| $($s.Name) | $($s.Role) | $($s.Fit) | $($s.Source) | $($s.Email) | $($s.Score) | $($s.Notes) |"
    }
    $supervisorTable = $supervisorRows -join "`n"

    $readme = @"
# $School PhD Application Package

## Decision Summary

- Region: malaysia
- Program target: $Program
- Priority level: $Priority
- Funding route: $Funding
- Immigration route: $Immigration
- Current action: verified first-contact target; send first outreach after final email confirmation.

## Why This School

$Why

## Proposed Research Angle

**Working title:** $Title

$Angle

## Package Status

- Supervisor verified: yes
- Funding verified: partially
- Immigration rule verified: partially
- School-specific PDFs generated: no
- Email sent: no
- Response received: no

## Use Rule

Do not send the XMUM generic materials unchanged. Tailor CV, RCN, RP, portfolio statement, and email to the specific supervisor and school before outreach.
"@

    $targetSupervisors = @"
# Target Supervisors - $School

## Shortlist

| Name | Role | Fit | Official source | Email | Score | Notes |
|---|---|---|---|---|---|---|
$supervisorTable

## First Outreach Target

- Selected supervisor: $SelectedSupervisor
- Selected email: $SelectedEmail
- Verification source: $SelectedSource
- Verification evidence: $SelectedEvidence

## Verification Checklist

- Confirmed current affiliation from official university page or official staff directory.
- Confirmed a concrete institutional email or public official contact.
- Matched supervisor research to Wen Quan's proposed CS/AI transition.
- Avoided generic admissions-only contact as the primary target unless no safe personal email was available.
"@

    $fit = @"
# Tailored Research Fit - $School

## School-Specific Framing

For $School, frame Wen Quan's second PhD as a computer science transition from age-friendly built environment research into:

**$Title**

## Fit With Wen Quan's Background

- Completed PhD in Interior Design at Universiti Sains Malaysia with age-friendly built environment and AI-assisted assessment focus.
- Published and under-review work using LSTM, NLP/SciBERT, contrastive learning, hyperbolic embedding, GANs, point-cloud analysis, meta-learning, random forest regression, and explainable AI.
- Current AI/CS manuscripts under review or revision processing in *Neural Networks* and *Egyptian Informatics Journal*.
- Existing web portfolio: China Age-Friendly Community Assessment Map.
- Second PhD rationale: the first PhD created domain authority; the second PhD should develop CS methods in multimodal AI, spatial intelligence, HCI, and explainable decision support.

## School-Specific Angle

$Angle

## Research Keywords To Emphasize

- knowledge-guided vision-language models
- lightweight spatial intelligence
- age-friendly indoor assessment
- explainable AI and expert validation
- human-centered AI decision support
- visual/spatial evidence for accessibility and fall-risk assessment
"@

    $email = @"
# Outreach Email - $School

Subject: Prospective PhD applicant: $Title

Dear Professor $($SelectedSupervisor.Split(' ')[-1]),

My name is Wen Quan. I have completed a PhD in Interior Design at Universiti Sains Malaysia, with a research focus on age-friendly built environments, AI-assisted assessment, and spatial evaluation.

I am now seeking a second PhD in Computer Science / AI / HCI to move from domain-specific built environment research toward computational methods. For $School, I am particularly interested in a project on "$Title".

My recent work includes published and under-review studies involving LSTM-based prediction, NLP/SciBERT-assisted framework development, contrastive learning, hyperbolic embedding, GANs, point-cloud analysis, meta-learning, and explainable AI. Two current AI/CS manuscripts are under review/revision processing in Neural Networks and Egyptian Informatics Journal. I also maintain a web-based portfolio demo:

https://wenquan0816.github.io/age-friendly-community-map/

$Personalization

Would you be open to considering a PhD applicant with my interdisciplinary background? I would be happy to send a short research concept note, CV, and portfolio.

Best regards,

Wen Quan

## Before Sending

- Recipient: $SelectedSupervisor <$SelectedEmail>
- Check the salutation and supervisor title one more time.
- Attach only the school-specific files from `attachments/` after PDF generation.
- Do not attach passport, transcript, photo, or identity documents during first outreach.
"@

    $verification = @"
# Pre-Send Verification - $School

## Selected Recipient

- School: $School
- Package: malaysia/$Slug
- Selected supervisor: $SelectedSupervisor
- Email to use: $SelectedEmail
- Official source: $SelectedSource
- Evidence checked: $SelectedEvidence
- Current decision: ready for first outreach after final send confirmation.

## Fit Check

- Proposed title: $Title
- Match to supervisor: $Personalization
- Match to Wen Quan: completed PhD in Interior Design plus AI-assisted built environment research; proposed second PhD is method-development in CS/AI/spatial intelligence.

## Send Check

- Email body exists: yes, `outreach_email.md`
- CV profile adapted: yes, 'attachments/Tailored_CV_Profile.md'
- RCN adapted: yes, 'attachments/Tailored_RCN.md'
- RP abstract adapted: yes, 'attachments/Tailored_RP_Abstract.md'
- Portfolio statement adapted: yes, 'attachments/Tailored_Portfolio_Statement.md'
- Sensitive files excluded: yes
- Needs final human confirmation before Gmail send: yes
"@

    $attachmentsReadme = @"
# Attachments - $School

This folder contains school-specific attachment drafts. These are not final PDFs yet.

## Drafts Created

- `Tailored_CV_Profile.md`
- `Tailored_RCN.md`
- `Tailored_RP_Abstract.md`
- `Tailored_Portfolio_Statement.md`

## Final PDF Naming Convention

- `Wen_Quan_CV_$Slug.pdf`
- `Wen_Quan_RCN_$Slug.pdf`
- `Wen_Quan_RP_$Slug.pdf`
- `Wen_Quan_AI_CS_Portfolio_$Slug.pdf`

## Source Files To Adapt

- application_materials/01_Academic_CV_XMUM_PhD_CS.md
- application_materials/02_Research_Concept_Note_XMUM_PhD_CS.md
- application_materials/03_Research_Proposal_XMUM_PhD_CS.md
- application_materials/04_AI_CS_Portfolio.md

## Sensitive Documents

Do not commit passport, photos, certificates, transcripts, or identity documents here.
"@

    $cv = @"
# Tailored CV Profile - $School

Wen Quan is an AI-assisted built environment researcher with a completed PhD in Interior Design from Universiti Sains Malaysia. For $School, the second PhD should be framed as a move into computer science methods for **$Title**.

The CV profile should emphasize:

- AI/CS methods already used: LSTM, NLP/SciBERT, contrastive learning, hyperbolic embedding, GANs, random forest, point-cloud analysis, meta-learning, and explainable AI.
- Current AI/CS manuscripts in *Neural Networks* and *Egyptian Informatics Journal*.
- The age-friendly community map as a working AI/CS portfolio demo.
- The second PhD rationale: domain expertise is already established; the new PhD is for computational method development.

School-specific sentence to insert:

My proposed PhD at $School would focus on $Title, connecting my age-friendly built environment foundation with the school's strength in $($Personalization -replace '^I see a possible fit with your work on ', '' -replace '\. My proposed research.*$', '' -replace '\.$', '').
"@

    $rcn = @"
# Tailored Research Concept Note - $School

## Proposed Title

$Title

## Concept

This project will develop a knowledge-guided multimodal AI framework for assessing age-friendly indoor environments. The system will combine indoor images, possible point-cloud or layout information, and structured design knowledge to identify accessibility, safety, fall-risk, and caregiving-space issues.

## Why It Fits $School

$Angle

## Core CS Contribution

- Multimodal spatial representation for indoor environment assessment.
- Knowledge-guided reasoning over design rules and visual evidence.
- Explainable output for expert review and design recommendation.
- Human-AI workflow for validating spatial risk assessment.

## Feasible Data Strategy

Use a lightweight, staged dataset:

- 20-30 real cases for initial proof of concept.
- 80-150 rooms or spaces.
- 300-700 indoor images or screenshots.
- Expert labels for risk categories and recommendation quality.

This avoids over-promising a large world-model dataset at application stage.
"@

    $rp = @"
# Tailored Research Proposal Abstract - $School

## Working Title

$Title

## Abstract

Age-friendly indoor environment assessment is still largely manual, checklist-based, and difficult to scale. General-purpose AI and vision-language models can describe indoor scenes, but they are not reliably grounded in age-friendly design knowledge, fall-risk prevention, accessibility rules, or caregiving requirements.

This proposed PhD will develop a knowledge-guided multimodal spatial intelligence framework for age-friendly indoor assessment and design recommendation. The framework will use existing vision-language and computer vision tools, structured design knowledge, and expert validation to classify spatial risks and generate explainable recommendations.

At $School, the proposal should be tailored toward the selected supervisor's strengths. The expected contribution is a lightweight, explainable, and human-centered AI workflow that connects computer science methods with a high-impact aging-in-place application.
"@

    $portfolio = @"
# Tailored Portfolio Statement - $School

The China Age-Friendly Community Assessment Map demonstrates Wen Quan's ability to translate built environment research into a computational assessment prototype:

https://wenquan0816.github.io/age-friendly-community-map/

For $School, present the demo as:

- Evidence of web-based system development and interactive visualization.
- A starting point for human-AI decision-support interfaces.
- A bridge from community-level assessment to indoor spatial intelligence.
- A deployable prototype foundation for expert validation and supervisor discussion.

Suggested sentence:

'This portfolio prototype can be extended at $School into a multimodal indoor assessment system that combines vision-language models, spatial data, design knowledge, and expert-in-the-loop validation.'
"@

    Set-Content -Path (Join-Path $dir 'README.md') -Value $readme -Encoding UTF8
    Set-Content -Path (Join-Path $dir 'target_supervisors.md') -Value $targetSupervisors -Encoding UTF8
    Set-Content -Path (Join-Path $dir 'tailored_research_fit.md') -Value $fit -Encoding UTF8
    Set-Content -Path (Join-Path $dir 'outreach_email.md') -Value $email -Encoding UTF8
    Set-Content -Path (Join-Path $dir 'pre_send_verification.md') -Value $verification -Encoding UTF8
    Set-Content -Path (Join-Path $attach 'README.md') -Value $attachmentsReadme -Encoding UTF8
    Set-Content -Path (Join-Path $attach 'Tailored_CV_Profile.md') -Value $cv -Encoding UTF8
    Set-Content -Path (Join-Path $attach 'Tailored_RCN.md') -Value $rcn -Encoding UTF8
    Set-Content -Path (Join-Path $attach 'Tailored_RP_Abstract.md') -Value $rp -Encoding UTF8
    Set-Content -Path (Join-Path $attach 'Tailored_Portfolio_Statement.md') -Value $portfolio -Encoding UTF8

    [pscustomobject]@{
        package = "malaysia/$Slug"
        school = $School
        status = 'ready_for_confirmation'
        name = $SelectedSupervisor
        email = $SelectedEmail
        subject = "Prospective PhD applicant: $Title"
        body = ($email -replace '(?s)^# Outreach Email[^\n]*\n\n', '' -replace '(?s)\n\n## Before Sending.*$', '').Trim()
    }
}

$queue = @()
$queue += New-MalaysiaPackage `
    -Slug 'university_of_malaya' `
    -School 'Universiti Malaya' `
    -Priority 'A' `
    -Program 'PhD in Computer Science / Artificial Intelligence / Computer Vision' `
    -Funding 'Target UM Graduate Research Assistantship, supervisor grant support, or external scholarship; self-funding only if fee route is acceptable.' `
    -Immigration 'Malaysia route is familiar after USM; verify current post-study, Employment Pass, and TalentCorp pathways.' `
    -Title 'Knowledge-Guided Computer Vision for Age-Friendly Indoor Spatial Assessment' `
    -Why 'UM is Malaysia''s strongest CS/AI public-university target and has a direct computer vision and machine learning fit through the Department of Artificial Intelligence.' `
    -Angle 'Frame the project as a rigorous computer vision and machine learning PhD that uses age-friendly indoor assessment as the application domain, with explainable outputs for design experts.' `
    -Supervisors @(
        [pscustomobject]@{Name='Chee Seng Chan'; Role='Professor, Department of Artificial Intelligence, Faculty of Computer Science and Information Technology'; Fit='Direct fit in computer vision and machine learning; strong target if proposal emphasizes VLM/CV, scene understanding, and explainable spatial assessment.'; Source='https://umexpert.um.edu.my/cs-chan'; Email='cs.chan@um.edu.my'; Score='High'; Notes='Best first outreach target.'},
        [pscustomobject]@{Name='Loo Chu Kiong'; Role='Professor, Department of Artificial Intelligence'; Fit='Fit through explainable AI, machine intelligence, neurorobotics, and trustworthy/sustainable AI.'; Source='https://umexpert.um.edu.my/ckloo-um'; Email='ckloo.um@um.edu.my'; Score='Medium-High'; Notes='Backup if proposal leans toward explainable AI/robotics.'},
        [pscustomobject]@{Name='Aznul Qalid Md Sabri'; Role='Associate Professor, Department of Artificial Intelligence'; Fit='Applied AI and innovation fit; less direct than Chan for CV/VLM.'; Source='https://umexpert.um.edu.my/aznulqalid'; Email='aznulqalid@um.edu.my'; Score='Medium'; Notes='Backup for applied AI direction.'}
    ) `
    -SelectedSupervisor 'Chee Seng Chan' `
    -SelectedEmail 'cs.chan@um.edu.my' `
    -SelectedSource 'https://umexpert.um.edu.my/cs-chan' `
    -SelectedEvidence 'Official UMEXPERT page lists Department of Artificial Intelligence, Faculty of Computer Science and Information Technology, email shown as cs.chan um.edu.my, and biography says he leads a computer vision and machine learning team.' `
    -Personalization 'I see a possible fit with your work on computer vision and machine learning because my proposed research uses vision-language and spatial AI methods to assess age-friendly indoor environments with explainable outputs for expert validation.'

$queue += New-MalaysiaPackage `
    -Slug 'universiti_sains_malaysia' `
    -School 'Universiti Sains Malaysia' `
    -Priority 'A' `
    -Program 'PhD in Computer Science / Artificial Intelligence / Computer Vision' `
    -Funding 'USM route may be lower-cost because Wen Quan is already based at USM; verify supervisor funding, graduate assistantship, and international fee rules.' `
    -Immigration 'Malaysia route is the most familiar; verify whether a second PhD status supports continued legal stay and later Employment Pass route.' `
    -Title 'Explainable Computer Vision for Age-Friendly Indoor Risk and Accessibility Assessment' `
    -Why 'USM is administratively familiar and has a direct School of Computer Sciences computer vision and medical image analysis fit.' `
    -Angle 'Frame the second PhD as a cross-school CS method-development continuation from the completed design PhD, avoiding the impression of repeating the first PhD.' `
    -Supervisors @(
        [pscustomobject]@{Name='Anusha Achuthan'; Role='Senior Lecturer, School of Computer Sciences'; Fit='Direct fit in computer vision, image processing, AI, machine learning, deep learning, computational intelligence, and medical image analysis.'; Source='https://cs.usm.my/index.php/faculty-member/490-anusha-achuthan-ts-dr'; Email='anusha@usm.my'; Score='High'; Notes='Best first outreach target.'},
        [pscustomobject]@{Name='Nur Intan Raihana Ruhaiyem'; Role='Senior Lecturer, School of Computer Sciences'; Fit='Fit through image processing for medical data, data visualisation, and computer vision.'; Source='https://cs.usm.my/index.php/faculty-member/194-nur-intan-raihana-ruhaiyem-dr'; Email='intanraihana@usm.my'; Score='Medium-High'; Notes='Backup if Anusha is unavailable.'},
        [pscustomobject]@{Name='Mohd Halim Mohd Noor'; Role='Associate Professor, School of Computer Sciences'; Fit='USM Computer Vision and Image Processing group member; use as backup after confirming current research availability.'; Source='https://cs.usm.my/index.php/research/data-to-knowledge/research-expertise-dtk/computer-vision-image-processing'; Email='halimnoor@usm.my'; Score='Medium'; Notes='Backup based on USM staff list and CVIP group.'}
    ) `
    -SelectedSupervisor 'Anusha Achuthan' `
    -SelectedEmail 'anusha@usm.my' `
    -SelectedSource 'https://cs.usm.my/index.php/faculty-member/490-anusha-achuthan-ts-dr' `
    -SelectedEvidence 'Official USM staff page lists Senior Lecturer in School of Computer Sciences and research interests in Computer Vision, Image Processing, AI, Machine Learning, Deep Learning, Computational Intelligence.' `
    -Personalization 'I see a possible fit with your work on computer vision, image processing, artificial intelligence, machine learning, deep learning, and medical image analysis because my proposed research needs explainable visual assessment of indoor spatial risks and accessibility barriers.'

$queue += New-MalaysiaPackage `
    -Slug 'monash_university_malaysia' `
    -School 'Monash University Malaysia' `
    -Priority 'A' `
    -Program 'PhD in Information Technology / Computer Science / Human-Centred Computing' `
    -Funding 'Target supervisor project support, Monash graduate research scholarship, or Malaysia-campus fee route; verify whether HDR supervision is Malaysia-based or Australia-led.' `
    -Immigration 'Malaysia route is feasible if Malaysia-campus enrolment supports student pass and later employment route; verify official rules.' `
    -Title 'Human-Centred Computer Vision for Age-Friendly Indoor Assessment' `
    -Why 'Monash Malaysia gives a stronger international brand while staying in Malaysia; Anuja Dharmaratne provides a direct image processing, computer vision, digital health, and HCC fit.' `
    -Angle 'Frame the project as human-centred computing plus computer vision, using indoor accessibility and older-adult safety as the use case.' `
    -Supervisors @(
        [pscustomobject]@{Name='Anuja Dharmaratne'; Role='Associate Professor, Department of Human Centred Computing'; Fit='Direct fit in image processing, computer vision, digital health, learning analytics, and ICT for society; profile states accepting PhD students.'; Source='https://research.monash.edu/en/persons/anuja-thimali-dharmaratne/'; Email='Anuja.Dharmaratne@monash.edu'; Score='High'; Notes='Best first outreach target.'},
        [pscustomobject]@{Name='Anuja Dharmaratne'; Role='Monash University Malaysia IT profile'; Fit='Malaysia campus page confirms School of IT affiliation and local contact email.'; Source='https://www.monash.edu.my/IT/research/our-researchers/dr-anuja-dharmaratne'; Email='anuja@monash.edu'; Score='High'; Notes='Local-campus email backup.'}
    ) `
    -SelectedSupervisor 'Anuja Dharmaratne' `
    -SelectedEmail 'Anuja.Dharmaratne@monash.edu' `
    -SelectedSource 'https://research.monash.edu/en/persons/anuja-thimali-dharmaratne/' `
    -SelectedEvidence 'Official Monash profile lists Associate Professor, Department of Human Centred Computing, email, Accepting PhD Students, and research interests in image processing, computer vision, digital health, and ICT for society.' `
    -Personalization 'I see a possible fit with your work on image processing, computer vision, digital health, and human-centred computing because my proposed research connects indoor spatial assessment with explainable visual evidence and expert-in-the-loop design recommendations.'

$queue += New-MalaysiaPackage `
    -Slug 'university_of_nottingham_malaysia' `
    -School 'University of Nottingham Malaysia' `
    -Priority 'A-' `
    -Program 'PhD in Computer Science / Artificial Intelligence / Intelligent Decision Support' `
    -Funding 'Target University of Nottingham Malaysia studentship, supervisor project support, or self-funded route only after fee check.' `
    -Immigration 'Malaysia route is feasible; verify student pass, work route, and whether UK-brand Malaysia PhD affects local employability.' `
    -Title 'Neural Computation and Spatial AI for Age-Friendly Indoor Decision Support' `
    -Why 'Nottingham Malaysia is a UK-brand Malaysia campus; Tomas Maul has direct neural computation, computer vision, image processing, AI, machine learning, and intelligent decision support fit.' `
    -Angle 'Frame the project as neural/computer-vision methods for explainable indoor decision support rather than generic built-environment design.' `
    -Supervisors @(
        [pscustomobject]@{Name='Tomas Maul'; Role='Professor, School of Computer Science, University of Nottingham Malaysia'; Fit='Direct fit in neural computation, computer vision, image processing, machine learning, natural computation, AI, and intelligent decision support.'; Source='https://www.nottingham.edu.my/computer-mathematical-sciences/People/tomas.maul'; Email='Tomas.Maul@nottingham.edu.my'; Score='High'; Notes='Best first outreach target.'}
    ) `
    -SelectedSupervisor 'Tomas Maul' `
    -SelectedEmail 'Tomas.Maul@nottingham.edu.my' `
    -SelectedSource 'https://www.nottingham.edu.my/computer-mathematical-sciences/People/tomas.maul' `
    -SelectedEvidence 'Official Nottingham Malaysia page lists contact email, School of Computer Science role, biography with pattern recognition/computer vision, and research summary covering neural computation, computer vision, image processing, machine learning, natural computation, AI, and intelligent decision support.' `
    -Personalization 'I see a possible fit with your work on neural computation, computer vision, image processing, machine learning, and intelligent decision support because my proposed research aims to build an explainable spatial AI workflow for age-friendly indoor assessment.'

$queue += New-MalaysiaPackage `
    -Slug 'xiamen_university_malaysia' `
    -School 'Xiamen University Malaysia' `
    -Priority 'A' `
    -Program 'PhD in Computer Science / Artificial Intelligence / Software Engineering' `
    -Funding 'Target XMUM scholarship, supervisor/project support, or manageable Malaysia-campus self-funded route after exact fee check.' `
    -Immigration 'Malaysia route is feasible; verify student pass and post-study employment route.' `
    -Title 'Multimodal AI and Human-Centred Spatial Intelligence for Age-Friendly Indoor Assessment' `
    -Why 'XMUM already has base application materials prepared and offers AI, CS/data science, software engineering, and human-centred AI-adjacent staff in Malaysia.' `
    -Angle 'Frame XMUM as the fastest application route: reuse the existing XMUM CV/RCN/RP/portfolio base, but target the message to an AI or HCI-fit supervisor.' `
    -Supervisors @(
        [pscustomobject]@{Name='Yingqian Zhang'; Role='Professor, Bachelor of Engineering in Artificial Intelligence, School of Artificial Intelligence and Robotics'; Fit='Strong AI-methods fit through LLM/multimodal applications, AI-industry applications, AI security, and AI leadership.'; Source='https://www.xmu.edu.my/staff/professor-dr-yingqian-zhang'; Email='yingqian.zhang@xmu.edu.my'; Score='High'; Notes='Best first outreach target if proposal emphasizes AI/multimodal methods.'},
        [pscustomobject]@{Name='Shaidah Binti Jusoh'; Role='Assistant Professor, Bachelor of Engineering in Artificial Intelligence'; Fit='Good fit through intelligent systems, NLP, machine learning, and HCI.'; Source='https://www.xmu.edu.my/staff/assistant-prof-dr-shaidah-binti-jusoh'; Email='shaidah.jusoh@xmu.edu.my'; Score='Medium-High'; Notes='Strong backup if proposal emphasizes HCI/NLP/intelligent decision support.'},
        [pscustomobject]@{Name='Chandra Reka Ramachandiran'; Role='Assistant Professor and Head of Programme for Software Engineering'; Fit='Good fit through affective engineering, instructional technologies, HCI, mixed reality, and AI.'; Source='https://www.xmu.edu.my/staff/asst-prof-dr-chandra-reka-ramachandiran'; Email=''; Score='Medium'; Notes='Use only after confirming public email from official page.'},
        [pscustomobject]@{Name='Goh Sim Kuan'; Role='Assistant Professor, Bachelor of Engineering in Artificial Intelligence'; Fit='Relevant through multimodal AI and brain-computer interface applications.'; Source='https://www.xmu.edu.my/staff/assistant-prof-dr-goh-sim-kuan'; Email='simkuan.goh@xmu.edu.my'; Score='Medium-High'; Notes='Backup if multimodal AI is prioritized.'}
    ) `
    -SelectedSupervisor 'Yingqian Zhang' `
    -SelectedEmail 'yingqian.zhang@xmu.edu.my' `
    -SelectedSource 'https://www.xmu.edu.my/staff/professor-dr-yingqian-zhang' `
    -SelectedEvidence 'Official XMUM page lists Professor in Artificial Intelligence, email, research interests in LLM/multimodal applications, AI-industry applications, and AI security.' `
    -Personalization 'I see a possible fit with your work on large language models, multimodal applications, AI-industry applications, and AI security because my proposed research applies multimodal AI to age-friendly indoor spatial assessment and explainable decision support.'

$jsonPath = Join-Path $privateOutreach 'malaysia_ready_to_send_queue.json'
$csvPath = Join-Path $privateOutreach 'malaysia_ready_to_send_queue.csv'
$queue | ConvertTo-Json -Depth 5 | Set-Content -Encoding UTF8 $jsonPath
$queue | Select-Object package,status,name,email,subject | Export-Csv -NoTypeInformation -Encoding UTF8 $csvPath

Write-Host "Generated $($queue.Count) Malaysia school packages under $(Join-Path $schoolRoot 'malaysia')"
Write-Host "Wrote $jsonPath"
Write-Host "Wrote $csvPath"
