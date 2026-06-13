# Research Concept Note

**Applicant:** Wen Quan  
**Target program:** Doctor of Philosophy in Computer Science and Technology, Xiamen University Malaysia  
**Proposed field:** Artificial Intelligence / Human-Computer Interaction / Software Technology  

## Proposed Title

**A Knowledge-Guided Vision-Language Framework for Age-Friendly Indoor Space Assessment and Design Recommendation**

## Background

Population ageing creates increasing demand for safer, more accessible, and more supportive indoor living environments. Many age-friendly design problems are spatial and visual: blocked circulation paths, unsafe bathrooms, insufficient lighting, poor furniture arrangement, lack of handrails, inaccessible entrances, and inadequate caregiving space. Traditional assessment methods depend heavily on manual checklists and expert inspections, which are difficult to scale across homes, residential communities, and care environments.

Recent advances in vision-language models provide new opportunities for AI-assisted environmental assessment. These models can interpret images and textual prompts, but their outputs are often generic and insufficiently grounded in domain-specific design knowledge. For age-friendly indoor environments, reliable assessment requires both visual understanding and structured knowledge of accessibility, fall-risk prevention, caregiving, ergonomic design, and evidence-based renovation strategies.

## Research Gap

Existing indoor scene understanding research mainly focuses on object detection, semantic segmentation, navigation, or general 3D scene understanding. Built environment studies provide rich design guidelines and assessment frameworks, but they are often not computationally integrated with AI models. There is therefore a gap between general-purpose visual AI and domain-specific, explainable, age-friendly spatial assessment.

The proposed research addresses this gap by developing a lightweight spatial intelligence framework that combines vision-language models, an age-friendly design knowledge base, rule-guided reasoning, and expert validation.

## Aim

To develop and evaluate a knowledge-guided vision-language framework for assessing age-friendly indoor spaces and generating explainable design recommendations.

## Objectives

1. To construct a structured age-friendly indoor space knowledge base covering accessibility, fall-risk factors, caregiving space, lighting, furniture layout, bathroom safety, and design intervention principles.
2. To develop a vision-language assessment workflow that identifies spatial risks from indoor photographs, simple floor plans, or community environment images.
3. To integrate design rules and domain knowledge with VLM outputs to improve reliability, explainability, and practical relevance.
4. To build a prototype system that generates risk explanations and design recommendations for age-friendly indoor environments.
5. To validate the framework through expert evaluation and a small-scale dataset of real residential/community/care environment cases.

## Proposed Methodology

The study will follow a design science and AI-assisted assessment methodology.

First, age-friendly indoor environment criteria will be extracted from design guidelines, academic literature, existing assessment frameworks, and the applicant's previous research on age-friendly living environments and community assessment. These criteria will be organized into a structured knowledge base and risk taxonomy.

Second, a lightweight multimodal workflow will be developed using existing AI models, such as vision-language models, object detection, segmentation, and image-depth estimation where appropriate. The model will process indoor photographs, community environment images, and simple layout information to identify possible risk factors.

Third, domain rules will be used to constrain and interpret model outputs. Instead of relying only on open-ended AI responses, the system will classify issues into predefined risk categories and provide evidence-based design recommendations.

Fourth, a prototype will be developed and tested using the applicant's existing age-friendly community map demo as an initial portfolio foundation. The prototype will be extended conceptually toward age-friendly indoor space assessment and design recommendation.

Finally, expert validation will be conducted with interior design, accessibility, ageing, or built environment specialists. Evaluation will focus on risk identification accuracy, explanation quality, recommendation usefulness, and practical usability.

## Expected Data

The study will use a manageable, lightweight dataset rather than a large-scale visual benchmark.

Minimum feasible version:

- 20-30 real residential/community/care environment cases.
- 80-150 room or spatial samples.
- 300-700 photographs or visual records.
- 50-100 expert design recommendations.

Preferred PhD-scale version:

- 30-50 real cases.
- 150-250 rooms or spatial samples.
- 500-1000 photographs.
- 150-300 expert recommendations.
- Partial repeated expert annotation for reliability checking.

## Expected Contributions

The research is expected to contribute:

- A structured age-friendly indoor space knowledge base.
- A knowledge-guided VLM framework for spatial risk assessment.
- An explainable design recommendation workflow for age-friendly renovation.
- A prototype system demonstrating AI-assisted assessment and decision support.
- A bridge between computer science, HCI, AI applications, and age-friendly built environment research.

## Fit with XMUM

The project fits the PhD in Computer Science and Technology through its focus on AI, software technology, human-computer interaction, knowledge-based systems, multimodal AI, and applied computer vision. It is particularly suitable for supervision in AI, HCI, software engineering, computer vision, or intelligent healthcare-related research areas.

