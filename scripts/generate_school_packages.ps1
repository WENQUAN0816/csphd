$ErrorActionPreference = "Stop"

$root = Split-Path -Parent $PSScriptRoot
$base = Join-Path $root "school_packages"

function New-SchoolPackage {
    param(
        [string]$Region,
        [string]$Slug,
        [string]$School,
        [string]$Priority,
        [string]$Program,
        [string]$Funding,
        [string]$Immigration,
        [string]$Why,
        [string]$Angle,
        [string]$Title,
        [string[]]$Supervisors
    )

    $dir = Join-Path (Join-Path $base $Region) $Slug
    $attach = Join-Path $dir "attachments"
    New-Item -ItemType Directory -Force -Path $attach | Out-Null

    $supervisorBullets = ($Supervisors | ForEach-Object { "- $_" }) -join "`n"
    $primarySupervisor = if ($Supervisors.Count -gt 0) { ($Supervisors[0] -split " - ")[0] } else { "<Supervisor Name>" }

    $readme = @"
# $School PhD Application Package

## Decision Summary

- Region: $Region
- Program target: $Program
- Priority level: $Priority
- Funding route: $Funding
- Immigration route: $Immigration
- Current action: verify supervisor fit, funding deadline, and official immigration pathway before sending.

## Why This School

$Why

## Proposed Research Angle

**Working title:** $Title

$Angle

## Package Status

- Supervisor verified: no
- Funding verified: no
- Immigration rule verified: no
- School-specific PDFs generated: no
- Email sent: no
- Response received: no

## Use Rule

Do not send the XMUM generic materials unchanged. Tailor CV, RCN, RP, portfolio statement, and email to the specific supervisor and school before outreach.
"@

    $targetSupervisors = @"
# Target Supervisors - $School

## Shortlist

$supervisorBullets

## Best-Fit Supervisor Type

Prioritize supervisors working in at least one of these areas:

- Human-AI interaction, HCI, accessibility, or assistive technology.
- Computer vision, 3D scene understanding, point clouds, spatial computing, or vision-language models.
- AI for health, aging, smart homes, or decision-support systems.
- Explainable AI, knowledge-guided AI, or human-centered AI.

## Verification Checklist

- Confirm current affiliation and email from the official university page.
- Confirm whether the supervisor is accepting PhD students.
- Confirm whether the supervisor can fund an international PhD student.
- Read 2-3 recent papers before sending the email.
- Replace all bracketed text in `outreach_email.md`.
"@

    $fit = @"
# Tailored Research Fit - $School

## School-Specific Framing

For $School, frame Wen Quan's second PhD as a computer science transition from age-friendly built environment research into:

**$Title**

## Fit With Wen Quan's Background

- Completed PhD in Interior Design with a focus on age-friendly built environments and AI-assisted assessment.
- Published AI-assisted built environment work using LSTM, NLP/SciBERT, contrastive learning, hyperbolic embedding, GANs, and random forest regression.
- Current AI/CS manuscripts under review/revision processing in *Neural Networks* and *Egyptian Informatics Journal*.
- Existing web portfolio: China Age-Friendly Community Assessment Map.
- Proposed second PhD rationale: first PhD built the domain foundation; second PhD develops CS methods in multimodal AI, spatial intelligence, HCI, and explainable decision support.

## Research Keywords To Emphasize

- knowledge-guided vision-language models
- lightweight spatial intelligence
- age-friendly indoor assessment
- point-cloud and layout-aware reasoning
- explainable AI and expert validation
- human-AI decision support

## School-Specific Angle

$Angle

## Documents To Tailor

- CV profile paragraph: mention $School and the supervisor's lab theme.
- RCN: change the first page to match the supervisor's methods and program keywords.
- RP: adjust methodology and expected contribution to the lab's core area.
- Portfolio: emphasize the demo as a bridge toward the supervisor's research area.
- Email: cite one recent paper or lab project before sending.
"@

    $email = @"
# Outreach Email - $School

Subject: Prospective PhD applicant: $Title

Dear Professor $primarySupervisor,

My name is Wen Quan. I have completed a PhD in Interior Design at Universiti Sains Malaysia, with a research focus on age-friendly built environments, AI-assisted assessment, and spatial evaluation.

I am now seeking a second PhD in Computer Science / AI / HCI to move from domain-specific built environment research toward computational methods. For $School, I am particularly interested in a project on **$Title**.

My recent work includes published and under-review studies involving LSTM-based prediction, NLP/SciBERT-assisted framework development, contrastive learning, hyperbolic embedding, GANs, point-cloud analysis, meta-learning, and explainable AI. Two current AI/CS manuscripts are under review/revision processing in *Neural Networks* and *Egyptian Informatics Journal*. I also maintain a web-based portfolio demo:

https://wenquan0816.github.io/age-friendly-community-map/

I see a possible fit with your work on [insert verified supervisor topic or recent paper] because my proposed research would connect multimodal AI, spatial assessment, and human-centered decision support for aging-in-place environments.

Would you be open to considering a PhD applicant with my interdisciplinary background? I would be happy to send a short research concept note, CV, and portfolio.

Best regards,

Wen Quan

## Before Sending

- Replace the greeting with the verified supervisor name.
- Add one specific recent paper or project.
- Confirm funding and PhD admission route.
- Attach only the school-specific files from attachments/.
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

Wen Quan is an AI-assisted built environment researcher with a completed PhD in Interior Design from Universiti Sains Malaysia. For $School, his proposed second PhD should be framed as a transition into computer science methods for **$Title**.

The CV should emphasize:

- AI/CS methods already used: LSTM, NLP/SciBERT, contrastive learning, hyperbolic embedding, GANs, random forest, point-cloud analysis, meta-learning, and explainable AI.
- Under-review AI/CS manuscripts in *Neural Networks* and *Egyptian Informatics Journal*.
- The age-friendly community map as a working portfolio demo.
- The second PhD rationale: domain foundation already completed; the new PhD is for computational method development.

School-specific sentence to insert:

`My proposed PhD at $School would focus on $Title, connecting my age-friendly built environment foundation with the school's strengths in [insert verified lab strength].`
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

At $School, the proposal should be tailored toward the supervisor's strengths in [insert verified lab strength]. The expected contribution is a lightweight, explainable, and human-centered AI workflow that connects computer science methods with a high-impact aging-in-place application.
"@

    $portfolio = @"
# Tailored Portfolio Statement - $School

The China Age-Friendly Community Assessment Map demonstrates Wen Quan's ability to translate built environment research into a computational assessment prototype.

For $School, present the demo as:

- Evidence of web-based system development and interactive visualization.
- A starting point for human-AI decision-support interfaces.
- A bridge from community-level assessment to indoor spatial intelligence.
- A deployable prototype foundation for expert validation and supervisor discussion.

Suggested sentence:

'This portfolio prototype can be extended at $School into a multimodal indoor assessment system that combines vision-language models, spatial data, design knowledge, and expert-in-the-loop validation.'
"@

    Set-Content -Path (Join-Path $dir "README.md") -Value $readme -Encoding UTF8
    Set-Content -Path (Join-Path $dir "target_supervisors.md") -Value $targetSupervisors -Encoding UTF8
    Set-Content -Path (Join-Path $dir "tailored_research_fit.md") -Value $fit -Encoding UTF8
    Set-Content -Path (Join-Path $dir "outreach_email.md") -Value $email -Encoding UTF8
    Set-Content -Path (Join-Path $attach "README.md") -Value $attachmentsReadme -Encoding UTF8
    Set-Content -Path (Join-Path $attach "Tailored_CV_Profile.md") -Value $cv -Encoding UTF8
    Set-Content -Path (Join-Path $attach "Tailored_RCN.md") -Value $rcn -Encoding UTF8
    Set-Content -Path (Join-Path $attach "Tailored_RP_Abstract.md") -Value $rp -Encoding UTF8
    Set-Content -Path (Join-Path $attach "Tailored_Portfolio_Statement.md") -Value $portfolio -Encoding UTF8
}

$schools = @(
    [pscustomobject]@{Region="canada"; Slug="university_of_waterloo"; School="University of Waterloo"; Priority="S"; Program="PhD in Computer Science / Systems Design Engineering / AI-HCI"; Funding="Funded PhD or assistantship route; verify supervisor funding and school minimum funding."; Immigration="Strong Ontario route; verify OINP PhD Graduate Stream, PGWP, and Express Entry rules."; Why="Waterloo is one of the strongest choices for HCI, human-AI interaction, accessibility, health technology, and CS funding culture."; Angle="Position the work as human-AI spatial assessment for aging-in-place, with expert-in-the-loop validation and explainable recommendations."; Title="Human-AI Spatial Intelligence for Age-Friendly Indoor Environment Assessment"; Supervisors=@("Cosmin Munteanu - HCI, accessibility, aging, speech and interactive systems (verify before sending).","Edith Law - human-AI collaboration, crowdsourcing, augmented intelligence (verify before sending).","Jesse Hoey - AI for health, cognitive assistance, decision-making under uncertainty (verify before sending).","Mark Hancock - HCI and interactive systems (verify before sending).")}
    [pscustomobject]@{Region="canada"; Slug="university_of_toronto"; School="University of Toronto"; Priority="A"; Program="PhD in Computer Science / Information / Robotics / AI"; Funding="Apply only if full funding or supervisor support is plausible; highly competitive."; Immigration="Ontario route is attractive; verify OINP PhD Graduate Stream and PGWP/Express Entry details."; Why="UofT has top-tier CS, AI, computer vision, graphics, and HCI reputation, but competition is very high."; Angle="Frame the proposal as a high-rigor CS project in multimodal spatial reasoning, 3D vision, and explainable assessment for age-friendly indoor environments."; Title="Knowledge-Guided Multimodal Spatial Reasoning for Age-Friendly Indoor Assessment"; Supervisors=@("Sanja Fidler - computer vision and visual reasoning (verify before sending).","Alec Jacobson - geometry processing and 3D computation (verify before sending).","Karan Singh - graphics, HCI, and design computation (verify before sending).","Steven Waslander - robotics and spatial perception (verify before sending).")}
    [pscustomobject]@{Region="canada"; Slug="york_university"; School="York University"; Priority="S"; Program="PhD in Computer Science / Electrical Engineering and Computer Science"; Funding="Funded PhD/assistantship route may be more realistic than top-tier schools; verify."; Immigration="Ontario route is attractive; verify OINP PhD Graduate Stream and PGWP rules."; Why="York offers a practical Ontario option with vision, HCI, accessibility, and applied computing fit."; Angle="Emphasize accessibility-aware computer vision and explainable spatial decision support for elderly home environments."; Title="Accessibility-Aware Computer Vision for Age-Friendly Indoor Spaces"; Supervisors=@("James Elder - computer vision and visual perception (verify before sending).","Melanie Baljko - HCI and accessibility-oriented technology (verify before sending).","Michael Jenkin - robotics, perception, and spatial systems (verify before sending).")}
    [pscustomobject]@{Region="canada"; Slug="university_of_ottawa"; School="University of Ottawa"; Priority="A"; Program="PhD in Computer Science / Electrical Engineering and Computer Science"; Funding="Funded PhD/assistantship route; verify supervisor funding."; Immigration="Ontario route is attractive; verify official PhD graduate and PGWP rules."; Why="Ottawa is suitable for applied AI, multimedia, HCI, health informatics, and bilingual public-sector tech networks."; Angle="Position the project as health-facing multimodal AI and decision support for aging-in-place."; Title="Explainable Multimodal AI for Aging-in-Place Indoor Risk Assessment"; Supervisors=@("Abdulmotaleb El Saddik - multimedia, HCI, digital health systems (verify before sending).","Diana Inkpen - NLP and applied AI (verify before sending).","Liam Peyton - health informatics and decision support (verify before sending).")}
    [pscustomobject]@{Region="canada"; Slug="carleton_university"; School="Carleton University"; Priority="A"; Program="PhD in Computer Science / Human-Computer Interaction"; Funding="Funded PhD/assistantship route; verify HCI and CS funding."; Immigration="Ontario route is attractive; verify OINP PhD Graduate Stream and PGWP rules."; Why="Carleton has a strong HCI/accessibility profile and is a realistic Ontario target."; Angle="Frame the project as an HCI and assistive technology system for expert-guided indoor accessibility assessment."; Title="Human-Centered AI for Age-Friendly Indoor Accessibility Assessment"; Supervisors=@("Audrey Girouard - HCI and interactive systems (verify before sending).","Anthony Whitehead - interactive systems and applied computing (verify before sending).","Ali Arya - HCI, serious games, and interactive technology (verify before sending).")}
    [pscustomobject]@{Region="canada"; Slug="mcgill_university"; School="McGill University"; Priority="A-"; Program="PhD in Computer Science / Human-Centered AI"; Funding="Strong school, but apply with funding/supervisor support; verify Quebec funding and tuition."; Immigration="Canada route possible, but Quebec rules differ from Ontario; verify before prioritizing."; Why="McGill is strong for HCI, accessibility, AI, and health-related computing, but immigration planning is more complex than Ontario."; Angle="Emphasize accessibility, healthy aging, and human-centered AI for indoor environments."; Title="Human-Centered AI for Accessible and Age-Friendly Indoor Environments"; Supervisors=@("Karyn Moffatt - accessibility, HCI, and aging-related technology (verify before sending).","Derek Ruths - social computing and applied AI (verify before sending).","Joelle Pineau - AI, reinforcement learning, and health applications (verify before sending).")}
    [pscustomobject]@{Region="new_zealand"; Slug="university_of_auckland"; School="University of Auckland"; Priority="S"; Program="PhD in Computer Science / Software Engineering / HCI"; Funding="International PhD tuition may be close to domestic rate; scholarships should still be pursued."; Immigration="Strong NZ route; verify doctoral post-study work and skilled migration rules."; Why="Auckland is the strongest New Zealand brand and fits HCI, AR, AI, visualization, and applied computing."; Angle="Frame the project as AR/HCI-ready spatial intelligence for age-friendly indoor assessment and design recommendation."; Title="Vision-Language and HCI Frameworks for Age-Friendly Indoor Spatial Assessment"; Supervisors=@("Beryl Plimmer - HCI and interaction design (verify before sending).","Burkhard Wuensche - computer graphics and visualization (verify before sending).","Yun Sing Koh - AI and machine learning (verify before sending).","Mark Billinghurst - AR/HCI connection to verify before sending.")}
    [pscustomobject]@{Region="new_zealand"; Slug="university_of_waikato"; School="University of Waikato"; Priority="A"; Program="PhD in Computer Science / AI and Machine Learning"; Funding="NZ PhD tuition advantage plus possible doctoral scholarships; verify."; Immigration="Strong NZ route; verify post-study work and skilled migration requirements."; Why="Waikato has a recognized ML tradition and may be more realistic than Auckland."; Angle="Pitch lightweight ML, meta-learning, and explainable assessment rather than large-scale VLM training."; Title="Lightweight Machine Learning for Age-Friendly Indoor Risk Assessment"; Supervisors=@("Eibe Frank - machine learning and data mining (verify before sending).","Albert Bifet - machine learning and data streams (verify before sending).","Bernhard Pfahringer - machine learning (verify before sending).")}
    [pscustomobject]@{Region="new_zealand"; Slug="university_of_canterbury"; School="University of Canterbury"; Priority="A"; Program="PhD in Computer Science / Human Interface Technology"; Funding="NZ tuition advantage plus scholarships; verify."; Immigration="Strong NZ route; verify official rules."; Why="Canterbury can fit HCI, VR, human interface technology, and applied AI."; Angle="Emphasize an interactive assessment system for expert validation of indoor spatial risks."; Title="Interactive Spatial AI for Age-Friendly Indoor Assessment"; Supervisors=@("Christoph Bartneck - human-robot interaction and human-centered technology (verify before sending).","Tanja Mitrovic - AI and intelligent systems (verify before sending).","Human Interface Technology Lab supervisors - verify current fit before sending.")}
    [pscustomobject]@{Region="new_zealand"; Slug="victoria_university_of_wellington"; School="Victoria University of Wellington"; Priority="A"; Program="PhD in Computer Science / AI / Software Engineering"; Funding="NZ tuition advantage plus scholarships; verify."; Immigration="Strong NZ route; verify official rules."; Why="Victoria Wellington has AI, software, evolutionary computation, and HCI-related strengths."; Angle="Use the proposal as an applied AI and software prototype for explainable age-friendly assessment."; Title="Explainable AI and Software Prototyping for Age-Friendly Indoor Assessment"; Supervisors=@("Mengjie Zhang - AI and evolutionary computation (verify before sending).","Bing Xue - machine learning and feature selection (verify before sending).","Ian Welch - software engineering and security-related computing (verify before sending).")}
    [pscustomobject]@{Region="new_zealand"; Slug="university_of_otago"; School="University of Otago"; Priority="A-"; Program="PhD in Computer Science / Health Informatics / HCI"; Funding="NZ tuition advantage plus scholarships; verify."; Immigration="Strong NZ route; verify official rules."; Why="Otago is useful if the project is framed around health, aging, and human-centered technology."; Angle="Emphasize health-aging assessment and expert validation rather than pure algorithm novelty."; Title="Human-Centered AI for Healthy Aging Indoor Environment Assessment"; Supervisors=@("Health informatics and HCI supervisors - verify before sending.","Computer vision or applied AI supervisors - verify before sending.","Aging and digital health collaborators - verify before sending.")}
    [pscustomobject]@{Region="australia"; Slug="monash_university"; School="Monash University"; Priority="A"; Program="PhD in Computer Science / AI / Human-Centred Computing"; Funding="Prioritize RTP or supervisor-funded route; avoid self-funded unless immigration and supervisor fit are exceptional."; Immigration="PR route is points/job dependent; verify Home Affairs rules before committing."; Why="Monash is strong in AI, computer vision, HCI, and has brand value; funding is the key filter."; Angle="Frame the project as VLM/spatial AI for aging-in-place with explainability and prototype validation."; Title="Knowledge-Guided Vision-Language Models for Age-Friendly Indoor Assessment"; Supervisors=@("Michael Wybrow - HCI, visualization, and interactive systems (verify before sending).","Geoff Webb - machine learning and data mining (verify before sending).","Tom Drummond - computer vision connection to verify before sending.","Human-Centred Computing group supervisors - verify before sending.")}
    [pscustomobject]@{Region="australia"; Slug="university_of_melbourne"; School="University of Melbourne"; Priority="A"; Program="PhD in Computing and Information Systems / AI / HCI"; Funding="Apply only with scholarship or strong supervisor support."; Immigration="PR route is points/job dependent; verify official rules."; Why="Melbourne has strong CS reputation, HCI, spatial computing, and health AI opportunities."; Angle="Emphasize high-quality HCI/AI evaluation and deployable decision support for indoor environments."; Title="Human-Centered Multimodal AI for Age-Friendly Indoor Decision Support"; Supervisors=@("Eduardo Velloso - HCI and interaction (verify before sending).","Lars Kulik - spatial computing and location-based systems (verify before sending).","Jianzhong Qi - data/spatial systems and AI (verify before sending).")}
    [pscustomobject]@{Region="australia"; Slug="unsw_sydney"; School="UNSW Sydney"; Priority="A"; Program="PhD in Computer Science / AI / HCI"; Funding="Apply only with RTP/scholarship or funded supervisor support."; Immigration="PR route is points/job dependent; verify official rules."; Why="UNSW has strong CS/AI reputation and is useful if fully funded."; Angle="Frame as applied AI and computer vision for safe and accessible indoor environments."; Title="Explainable Computer Vision for Age-Friendly Indoor Safety Assessment"; Supervisors=@("Toby Walsh - AI and responsible AI (verify before sending).","Flora Salim - spatio-temporal data and AI connection to verify before sending.","Computer vision / human-centered AI supervisors - verify before sending.")}
    [pscustomobject]@{Region="australia"; Slug="university_of_sydney"; School="University of Sydney"; Priority="A-"; Program="PhD in Computer Science / HCI / Robotics and Intelligent Systems"; Funding="Apply only with scholarship or supervisor support."; Immigration="PR route is points/job dependent; verify official rules."; Why="Sydney has strong HCI, AI, robotics, and health technology fit, but funding is critical."; Angle="Emphasize interactive, evidence-based AI support for indoor safety and accessibility."; Title="Interactive AI for Age-Friendly Indoor Safety and Accessibility Assessment"; Supervisors=@("Judy Kay - HCI and user modeling (verify before sending).","Fabio Ramos - machine learning and robotics (verify before sending).","Health/AI and HCI supervisors - verify before sending.")}
    [pscustomobject]@{Region="australia"; Slug="rmit_university"; School="RMIT University"; Priority="B+"; Program="PhD in Computer Science / Geospatial Science / Human-Computer Interaction"; Funding="Prioritize only if funded or supervisor fit is unusually strong."; Immigration="PR route is points/job dependent; verify official rules."; Why="RMIT can fit applied spatial systems, visualization, built environment technology, and urban analytics."; Angle="Frame as applied spatial intelligence and decision-support software for age-friendly environments."; Title="Applied Spatial Intelligence for Age-Friendly Built Environment Assessment"; Supervisors=@("Spatial information science supervisors - verify before sending.","Visualization/HCI supervisors - verify before sending.","AI for urban analytics supervisors - verify before sending.")}
    [pscustomobject]@{Region="hong_kong"; Slug="hkust"; School="The Hong Kong University of Science and Technology"; Priority="S"; Program="PhD in Computer Science and Engineering / AI"; Funding="Target HKPFS and university studentship."; Immigration="IANG and 7-year ordinary residence route are attractive; verify official rules."; Why="HKUST has strong CS/AI, computer vision, HCI, and Hong Kong funding potential."; Angle="Pitch a rigorous AI/VLM and 3D spatial reasoning project with age-friendly indoor assessment as the application."; Title="Knowledge-Guided VLM and 3D Spatial Reasoning for Age-Friendly Indoor Assessment"; Supervisors=@("Long Quan - computer vision and 3D vision (verify before sending).","Dit-Yan Yeung - machine learning and AI (verify before sending).","Pan Hui - HCI, mobile/ubiquitous computing, and human-centered systems (verify before sending).","Yangqiu Song - NLP and knowledge-aware AI (verify before sending).")}
    [pscustomobject]@{Region="hong_kong"; Slug="hku"; School="The University of Hong Kong"; Priority="S"; Program="PhD in Computer Science / Data Science / AI"; Funding="Target HKPFS and university studentship."; Immigration="IANG and 7-year ordinary residence route are attractive; verify official rules."; Why="HKU offers strong brand value and AI/graphics/data systems options."; Angle="Frame the project around data-driven and explainable spatial assessment with VLM support."; Title="Explainable Multimodal AI for Age-Friendly Indoor Spatial Assessment"; Supervisors=@("Wenping Wang - computer graphics and geometry (verify before sending).","Reynold Cheng - data systems and urban/AI data applications (verify before sending).","Chiew-Lan Tai - graphics and geometric computing (verify before sending).")}
    [pscustomobject]@{Region="hong_kong"; Slug="cuhk"; School="The Chinese University of Hong Kong"; Priority="S"; Program="PhD in Computer Science and Engineering / AI"; Funding="Target HKPFS and university studentship."; Immigration="IANG and 7-year ordinary residence route are attractive; verify official rules."; Why="CUHK is excellent for computer vision, medical AI, speech/NLP, and AI systems."; Angle="Position the proposal as CV/VLM plus health-aging indoor assessment."; Title="Computer Vision and Vision-Language Models for Age-Friendly Indoor Environments"; Supervisors=@("Jiaya Jia - computer vision (verify before sending).","Pheng-Ann Heng - medical imaging, VR, and visualization (verify before sending).","Helen Meng - speech and AI interaction (verify before sending).","Bei Yu - AI and computing systems (verify before sending).")}
    [pscustomobject]@{Region="hong_kong"; Slug="cityu"; School="City University of Hong Kong"; Priority="S"; Program="PhD in Computer Science / AI / Data Science"; Funding="Target HKPFS and CityU studentship."; Immigration="IANG and 7-year ordinary residence route are attractive; verify official rules."; Why="CityU can be a strong and realistic Hong Kong option for AI, image processing, and applied computing."; Angle="Emphasize applied AI, image analysis, and explainable spatial risk assessment."; Title="Applied AI and Image-Based Spatial Risk Assessment for Age-Friendly Homes"; Supervisors=@("Hong Yan - image processing and pattern recognition (verify before sending).","Computer vision and AI faculty in CS - verify before sending.","Health AI or smart city computing supervisors - verify before sending.")}
    [pscustomobject]@{Region="hong_kong"; Slug="polyu"; School="The Hong Kong Polytechnic University"; Priority="S"; Program="PhD in Computing / Design / Construction and Environment with AI"; Funding="Target HKPFS and PolyU studentship."; Immigration="IANG and 7-year ordinary residence route are attractive; verify official rules."; Why="PolyU is highly relevant because it bridges built environment, design, computing, smart city, and aging research."; Angle="Frame as a strong cross-disciplinary AI + built environment PhD with practical deployment value."; Title="AI-Assisted Spatial Intelligence for Age-Friendly Indoor Design Recommendation"; Supervisors=@("Computing faculty in AI/HCI/vision - verify before sending.","Design and human-centered technology supervisors - verify before sending.","Smart city and built environment AI supervisors - verify before sending.")}
    [pscustomobject]@{Region="usa"; Slug="university_of_washington"; School="University of Washington"; Priority="A"; Program="PhD in Computer Science and Engineering / HCI"; Funding="US route only if fully funded."; Immigration="US immigration is uncertain; later NIW/EB route may be possible but not guaranteed."; Why="UW is exceptionally strong in HCI, accessibility, ubiquitous sensing, visualization, and AI."; Angle="Pitch accessibility-aware human-AI spatial assessment for aging-in-place."; Title="Accessibility-Aware Human-AI Spatial Assessment for Aging-in-Place"; Supervisors=@("Jennifer Mankoff - accessibility and HCI (verify before sending).","Jon Froehlich - accessibility, sensing, and HCI (verify before sending).","Shwetak Patel - ubiquitous sensing and health technology (verify before sending).","Jeffrey Heer - visualization and human-centered data systems (verify before sending).")}
    [pscustomobject]@{Region="usa"; Slug="georgia_tech"; School="Georgia Institute of Technology"; Priority="A"; Program="PhD in Computer Science / Human-Centered Computing / AI"; Funding="US route only if fully funded."; Immigration="US immigration is uncertain; later NIW/EB route may be possible but not guaranteed."; Why="Georgia Tech is strong in HCI, AI, accessibility, robotics, and health-related computing."; Angle="Emphasize human-centered computing and AI decision support for older adults' indoor environments."; Title="Human-Centered AI for Age-Friendly Indoor Decision Support"; Supervisors=@("Duen Horng Chau - human-centered AI and visual analytics (verify before sending).","James M. Rehg - computer vision and health applications (verify before sending).","Ashok Goel - AI and cognitive systems (verify before sending).","Sonia Chernova - robotics and human-robot interaction (verify before sending).")}
    [pscustomobject]@{Region="usa"; Slug="carnegie_mellon_university"; School="Carnegie Mellon University"; Priority="A"; Program="PhD in Human-Computer Interaction / Computer Science / Robotics"; Funding="US route only if fully funded; extremely competitive."; Immigration="US immigration is uncertain; later NIW/EB route may be possible but not guaranteed."; Why="CMU is a top HCI/AI/CV target; apply as a stretch only with very tailored supervisor fit."; Angle="Frame as HCI + VLM + spatial computing for assistive indoor design assessment."; Title="Human-Centered Vision-Language Systems for Age-Friendly Indoor Assessment"; Supervisors=@("Jodi Forlizzi - HCI and design research (verify before sending).","Chris Harrison - HCI and interactive systems (verify before sending).","Deva Ramanan - computer vision (verify before sending).","Martial Hebert - robotics and perception (verify before sending).")}
    [pscustomobject]@{Region="usa"; Slug="uiuc"; School="University of Illinois Urbana-Champaign"; Priority="A"; Program="PhD in Computer Science / HCI / Vision"; Funding="US route only if fully funded."; Immigration="US immigration is uncertain; later NIW/EB route may be possible but not guaranteed."; Why="UIUC has elite CS, computer vision, HCI, and visualization strengths."; Angle="Position as robust computer vision and explainable spatial assessment for indoor safety."; Title="Explainable Computer Vision for Indoor Fall-Risk and Accessibility Assessment"; Supervisors=@("Derek Hoiem - computer vision and scene understanding (verify before sending).","Svetlana Lazebnik - computer vision (verify before sending).","David Forsyth - computer vision (verify before sending).","Karrie Karahalios - HCI and social computing (verify before sending).")}
    [pscustomobject]@{Region="usa"; Slug="northeastern_university"; School="Northeastern University"; Priority="B+"; Program="PhD in Computer Science / Personal Health Informatics / HCI"; Funding="US route only if funded; co-op ecosystem may help later employment but not guaranteed."; Immigration="US immigration is uncertain; later NIW/EB route may be possible but not guaranteed."; Why="Northeastern can fit HCI, health technology, accessibility, and applied AI."; Angle="Frame around health-facing HCI and spatial decision support for older adults."; Title="Health-Facing HCI and AI for Age-Friendly Indoor Environments"; Supervisors=@("Stacy Branham - accessibility and HCI (verify before sending).","Personal Health Informatics faculty - verify before sending.","Human-centered AI and visualization supervisors - verify before sending.")}
    [pscustomobject]@{Region="usa"; Slug="arizona_state_university"; School="Arizona State University"; Priority="B+"; Program="PhD in Computer Science / AI / Design Informatics"; Funding="Funded preferred; do not self-fund unless immigration/job strategy is strong."; Immigration="US immigration is uncertain; later NIW/EB route may be possible but not guaranteed."; Why="ASU can be a more realistic US option for applied AI, HCI, smart environments, and aging-related work."; Angle="Emphasize applied AI prototype development and deployable indoor assessment."; Title="Applied AI Prototypes for Age-Friendly Indoor Spatial Assessment"; Supervisors=@("Subbarao Kambhampati - AI and planning (verify before sending).","Baoxin Li - computer vision (verify before sending).","Heni Ben Amor - robotics and human-robot interaction (verify before sending).")}
    [pscustomobject]@{Region="usa"; Slug="university_of_colorado_boulder"; School="University of Colorado Boulder"; Priority="B+"; Program="PhD in Computer Science / Creative Technology and Design / HCI"; Funding="US route only if funded."; Immigration="US immigration is uncertain; later NIW/EB route may be possible but not guaranteed."; Why="CU Boulder is strong for HCI, accessibility, ubiquitous computing, and human-centered technology."; Angle="Frame as accessibility-first HCI and computer vision for older adults' home safety."; Title="Accessibility-First HCI and Spatial AI for Older Adults' Home Safety"; Supervisors=@("Shaun Kane - accessibility and HCI (verify before sending).","Tom Yeh - HCI and accessibility technology (verify before sending).","Danna Gurari - computer vision and accessibility (verify before sending).","Leysia Palen - HCI and crisis/decision support (verify before sending).")}
    [pscustomobject]@{Region="europe"; Slug="kth_royal_institute_of_technology"; School="KTH Royal Institute of Technology"; Priority="A"; Program="Paid doctoral position in Computer Science / HCI / Robotics / AI"; Funding="Prioritize paid doctoral employment or funded project."; Immigration="Sweden route can be attractive through doctoral/research residence and later work; verify official rules."; Why="KTH is strong in robotics, HCI, visualization, and technical systems, with paid PhD openings."; Angle="Frame as spatial AI and human-centered technology for safe aging-in-place."; Title="Human-Centered Spatial AI for Safe Aging-in-Place Environments"; Supervisors=@("Danica Kragic - robotics and computer vision (verify before sending).","Mario Romero - HCI and visualization (verify before sending).","KTH HCI/visualization/robotics faculty - verify before sending.")}
    [pscustomobject]@{Region="europe"; Slug="chalmers_university_of_technology"; School="Chalmers University of Technology"; Priority="A"; Program="Paid doctoral position in Computer Science / Interaction Design / AI"; Funding="Prioritize paid doctoral employment."; Immigration="Sweden route can be attractive; verify official rules."; Why="Chalmers can fit HCI, interaction design, computer vision, and engineering-driven AI."; Angle="Pitch an interaction-design and AI assessment system for age-friendly homes."; Title="Interaction-Centered AI for Age-Friendly Indoor Assessment"; Supervisors=@("Morten Fjeld - HCI and interaction design (verify before sending).","Fredrik Kahl - computer vision connection to verify before sending.","AI/interaction design doctoral openings - verify before sending.")}
    [pscustomobject]@{Region="europe"; Slug="lund_university"; School="Lund University"; Priority="A-"; Program="Paid doctoral position in Computer Science / AI / Design Sciences"; Funding="Prioritize paid doctoral employment."; Immigration="Sweden route can be attractive; verify official rules."; Why="Lund is useful if a paid project aligns with AI, design science, or health/aging technology."; Angle="Frame as design-science AI for expert-validated indoor assessment."; Title="Design-Science AI for Age-Friendly Indoor Spatial Assessment"; Supervisors=@("Computer vision and AI faculty - verify before sending.","Design science and digital health supervisors - verify before sending.","Accessibility/HCI supervisors - verify before sending.")}
    [pscustomobject]@{Region="europe"; Slug="linkoping_university"; School="Linkoping University"; Priority="A-"; Program="Paid doctoral position in AI / Computer Vision / Visualization"; Funding="Prioritize paid doctoral employment."; Immigration="Sweden route can be attractive; verify official rules."; Why="Linkoping has strong visualization, AI, and computer vision groups, especially for spatial and image understanding."; Angle="Emphasize visualization, point-cloud reasoning, and explainable spatial assessment."; Title="Visual Analytics and Spatial AI for Age-Friendly Indoor Risk Assessment"; Supervisors=@("Michael Felsberg - computer vision (verify before sending).","Fredrik Heintz - AI and autonomous systems (verify before sending).","Anders Ynnerman - visualization and scientific computing (verify before sending).")}
    [pscustomobject]@{Region="europe"; Slug="aalto_university"; School="Aalto University"; Priority="A"; Program="Doctoral Programme in Science / Computer Science / HCI"; Funding="Prioritize funded doctoral employment or scholarship route."; Immigration="Finland route may be attractive after graduation/work; verify official rules."; Why="Aalto is highly relevant for HCI, human-centered AI, computational design, and machine learning."; Angle="Frame as human-centered AI and computational design for accessible indoor environments."; Title="Human-Centered AI and Computational Design for Age-Friendly Indoor Environments"; Supervisors=@("Antti Oulasvirta - HCI and computational interaction (verify before sending).","Samuel Kaski - machine learning and AI (verify before sending).","Aalto HCI/design computation supervisors - verify before sending.")}
    [pscustomobject]@{Region="europe"; Slug="tu_delft"; School="TU Delft"; Priority="A"; Program="Paid PhD position in Computer Science / Human-Centered AI / Design"; Funding="Prioritize paid PhD employment."; Immigration="Netherlands route usually depends on post-PhD work; verify orientation year and highly skilled migrant rules."; Why="TU Delft has strong human-centered AI, design, urban/built environment, and computing fit."; Angle="Position as human-centered AI and design knowledge for spatial assessment."; Title="Human-Centered AI for Knowledge-Guided Indoor Spatial Assessment"; Supervisors=@("Alessandro Bozzon - human-centered AI and web information systems (verify before sending).","Ujwal Gadiraju - human-AI and crowd computing (verify before sending).","Hayley Hung - social signal processing and human-centered sensing (verify before sending).","Elmar Eisemann - graphics and visualization (verify before sending).")}
    [pscustomobject]@{Region="europe"; Slug="eindhoven_university_of_technology"; School="Eindhoven University of Technology"; Priority="A"; Program="Paid PhD position in Computer Science / Human-Technology Interaction"; Funding="Prioritize paid PhD employment."; Immigration="Netherlands route usually depends on post-PhD work; verify official rules."; Why="TU/e is relevant for human-technology interaction, smart environments, design, and built environment technology."; Angle="Frame as smart-home HCI and explainable AI for older adults' indoor environments."; Title="Smart-Home Human-AI Interaction for Age-Friendly Indoor Assessment"; Supervisors=@("Panos Markopoulos - HCI and human-technology interaction (verify before sending).","Berry Eggen - interaction design and intelligent environments (verify before sending).","Human-technology interaction faculty - verify before sending.")}
    [pscustomobject]@{Region="europe"; Slug="university_of_amsterdam"; School="University of Amsterdam"; Priority="A"; Program="PhD in AI / Computer Vision / Information Retrieval"; Funding="Prioritize funded doctoral position."; Immigration="Netherlands route usually depends on post-PhD work; verify official rules."; Why="UvA is strong in AI, computer vision, multimedia, and information retrieval."; Angle="Frame as VLM, multimedia understanding, and explainable indoor scene assessment."; Title="Vision-Language Scene Understanding for Age-Friendly Indoor Assessment"; Supervisors=@("Cees Snoek - computer vision and multimedia (verify before sending).","Marcel Worring - multimedia analytics and visual search (verify before sending).","Maarten de Rijke - information retrieval and AI (verify before sending).")}
    [pscustomobject]@{Region="europe"; Slug="technical_university_of_munich"; School="Technical University of Munich"; Priority="A"; Program="PhD / Research Associate in Computer Vision / AI / Robotics"; Funding="Prioritize funded research associate or scholarship route."; Immigration="Germany route can be strong after skilled work; verify residence and settlement rules."; Why="TUM is top-tier for vision, 3D reconstruction, robotics, and AI, but competitive."; Angle="Emphasize 3D vision and spatial intelligence for indoor assessment."; Title="3D Vision and Spatial Intelligence for Age-Friendly Indoor Assessment"; Supervisors=@("Daniel Cremers - computer vision and 3D reconstruction (verify before sending).","Matthias Niessner - 3D vision and scene reconstruction (verify before sending).","Nassir Navab - AR, medical imaging, and computer vision (verify before sending).")}
    [pscustomobject]@{Region="europe"; Slug="saarland_university_dfki"; School="Saarland University / DFKI"; Priority="A"; Program="PhD / Research Associate in AI / HCI / Computer Vision"; Funding="Prioritize DFKI or university funded research position."; Immigration="Germany route can be strong after skilled work; verify residence and settlement rules."; Why="Saarland/DFKI is strong in AI, HCI, language technology, and applied intelligent systems."; Angle="Pitch knowledge-guided AI and interactive spatial decision support."; Title="Knowledge-Guided AI for Interactive Indoor Spatial Assessment"; Supervisors=@("Antonio Kruger - HCI and intelligent user interfaces at DFKI/Saarland connection (verify before sending).","Andreas Dengel - AI and document/knowledge systems at DFKI connection (verify before sending).","Philipp Slusallek - graphics, simulation, and AI systems (verify before sending).")}
    [pscustomobject]@{Region="uk"; Slug="ucl"; School="University College London"; Priority="A"; Program="PhD in Computer Science / UCLIC / AI"; Funding="Apply only with studentship, scholarship, or strong funding route."; Immigration="Graduate Route helps temporarily, but PR is work-route dependent; verify official rules."; Why="UCL is top-ranked and strong in HCI, VR, computer vision, and human-centered AI."; Angle="Frame as HCI/VLM/VR-ready spatial assessment for aging-in-place."; Title="Human-Centered Vision-Language Systems for Age-Friendly Indoor Assessment"; Supervisors=@("Yvonne Rogers - HCI and interaction design (verify before sending).","Nadia Berthouze - affective computing and HCI (verify before sending).","Anthony Steed - VR and immersive systems (verify before sending).","Lourdes Agapito - 3D computer vision (verify before sending).")}
    [pscustomobject]@{Region="uk"; Slug="university_of_edinburgh"; School="University of Edinburgh"; Priority="A"; Program="PhD in Informatics / AI / Robotics"; Funding="Apply only with studentship/scholarship."; Immigration="Graduate Route helps temporarily, but PR is work-route dependent; verify official rules."; Why="Edinburgh is elite in AI and informatics; apply only if the proposal is methodologically strong."; Angle="Position as AI/spatial reasoning with explainable decision-support for healthy aging."; Title="Explainable Spatial Reasoning for Age-Friendly Indoor AI"; Supervisors=@("Sethu Vijayakumar - robotics and machine learning (verify before sending).","Mirella Lapata - NLP and AI (verify before sending).","Chris Williams - machine learning (verify before sending).")}
    [pscustomobject]@{Region="uk"; Slug="university_of_bristol"; School="University of Bristol"; Priority="A-"; Program="PhD in Computer Science / Robotics / HCI"; Funding="Apply only with studentship/scholarship."; Immigration="Graduate Route helps temporarily, but PR is work-route dependent; verify official rules."; Why="Bristol has strong CV, robotics, and HCI; good if funded."; Angle="Emphasize visual/spatial sensing and interactive assessment for older adults' homes."; Title="Visual-Spatial Sensing for Age-Friendly Indoor Assessment"; Supervisors=@("Walterio Mayol-Cuevas - computer vision and robotics (verify before sending).","Mike Fraser - HCI and interaction (verify before sending).","Dima Damen - computer vision and egocentric vision connection to verify before sending.")}
    [pscustomobject]@{Region="uk"; Slug="university_of_glasgow"; School="University of Glasgow"; Priority="A-"; Program="PhD in Computing Science / HCI / AI"; Funding="Apply only with studentship/scholarship."; Immigration="Graduate Route helps temporarily, but PR is work-route dependent; verify official rules."; Why="Glasgow has strong HCI and accessibility-related computing."; Angle="Frame as accessibility-focused HCI and AI for age-friendly indoor spaces."; Title="Accessibility-Focused HCI and AI for Age-Friendly Indoor Spaces"; Supervisors=@("Stephen Brewster - multimodal HCI (verify before sending).","Mohamed Khamis - HCI and interaction (verify before sending).","Alessandro Vinciarelli - social signal processing and AI (verify before sending).")}
    [pscustomobject]@{Region="uk"; Slug="university_of_nottingham"; School="University of Nottingham"; Priority="A-"; Program="PhD in Computer Science / Mixed Reality Lab / HCI"; Funding="Apply only with studentship/scholarship, especially for UK campus."; Immigration="Graduate Route helps temporarily, but PR is work-route dependent; verify official rules."; Why="Nottingham is strong in HCI, mixed reality, and human-centered systems; also has Malaysia connection."; Angle="Frame as mixed-reality and HCI-supported age-friendly spatial assessment."; Title="Mixed-Reality and Human-AI Tools for Age-Friendly Indoor Assessment"; Supervisors=@("Steve Benford - HCI and mixed reality (verify before sending).","Joel Fischer - HCI and human-centered systems (verify before sending).","Mixed Reality Lab supervisors - verify before sending.")}
)

foreach ($s in $schools) {
    New-SchoolPackage -Region $s.Region -Slug $s.Slug -School $s.School -Priority $s.Priority -Program $s.Program -Funding $s.Funding -Immigration $s.Immigration -Why $s.Why -Angle $s.Angle -Title $s.Title -Supervisors $s.Supervisors
}

Write-Host "Generated $($schools.Count) school packages under $base"
