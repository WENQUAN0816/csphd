# Project Rules for PhD Application Packages

## Scope

This repository stores Wen Quan's PhD application materials for Computer Science, AI, HCI, spatial intelligence, vision-language models, and age-friendly indoor environment research.

## One School, One Application Package

Each target school must have its own package directory under:

`school_packages/<country_or_region>/<school_slug>/`

Do not mix files for different schools in the same directory. Do not overwrite a generic file when a school-specific version is needed.

## Required Package Structure

Every school package should contain:

- `README.md` - school-level decision note, cost/funding/immigration fit, and current status.
- `target_supervisors.md` - supervisor shortlist, research fit, and verification notes.
- `tailored_research_fit.md` - how Wen Quan's background fits the school and target supervisors.
- `outreach_email.md` - school/supervisor-specific cold email draft.
- `attachments/README.md` - attachment checklist and naming convention for this school.

When school-specific PDFs are prepared, put them under:

`school_packages/<country_or_region>/<school_slug>/attachments/`

## Tailoring Requirement

All application documents must be adapted to the specific school, program, and supervisor before use.

For each school/supervisor, tailor at least:

- PhD title or subtitle.
- Research concept note.
- Research proposal framing.
- CV profile paragraph.
- AI/CS portfolio statement.
- Email subject line and first paragraph.
- Keywords matching the supervisor's lab, recent papers, and program strengths.

Do not send the XMUM version unchanged to other schools.

## Core Research Positioning

Use this as the default research identity unless a school-specific reason requires adjustment:

`Knowledge-guided vision-language models and lightweight spatial intelligence for age-friendly indoor space assessment and design recommendation.`

Acceptable variants:

- AI-assisted spatial intelligence for age-friendly indoor environments.
- Human-AI decision support for age-friendly housing assessment.
- Multimodal spatial assessment using vision-language models, point-cloud features, and design knowledge.
- Explainable AI for indoor fall-risk and accessibility assessment.

Avoid generic positioning such as "I want to transfer to AI" without a precise computational research problem.

## Second PhD Explanation

Every package must explain the second PhD consistently:

Wen Quan's first PhD established the domain foundation in age-friendly built environments and interior evaluation. The proposed second PhD is not a repeated degree; it is intended to develop computer science methods in multimodal AI, spatial intelligence, HCI, and explainable decision-support systems.

## Funding and Immigration Filter

Do not recommend or prioritize a school package unless at least one condition is credible:

- The PhD is normally fully funded or has a realistic scholarship route.
- The country/region has a strong post-PhD immigration route.
- The school is globally strong enough to justify risk if funding is uncertain.

If a school is not strong in ranking, not likely to fund, and not useful for immigration, mark it as `Do not prioritize`.

## Sensitive Documents

Do not commit passport scans, ID photos, degree certificates, transcripts, or private personal files to Git.

Use `private/` for local-only sensitive documents. This directory is ignored by Git.

School packages may include a checklist referencing private documents, but must not include the documents themselves unless the user explicitly requests it and the repository privacy/risk is checked.

## Verification Standard

Before a package is used for real outreach:

- Verify supervisor name, title, email, and current affiliation.
- Verify whether the supervisor is accepting PhD students.
- Verify program entry requirements and English-language requirements.
- Verify scholarship deadline and funding eligibility.
- Verify immigration rules from official government sources.

If information has not been verified, write `verify before sending`.

## Git Hygiene

Keep edits scoped to the relevant school package or shared application material.

Do not remove another agent's files or edits. Multiple agents may work in parallel.

Commit school-package updates with clear messages such as:

`docs: add Canada PhD school packages`

