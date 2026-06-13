# Research Proposal

**Applicant:** Wen Quan  
**Target Program:** Doctor of Philosophy in Computer Science and Technology, Xiamen University Malaysia  
**Proposed Field:** Artificial Intelligence / Human-Computer Interaction / Software Technology  

## Title

**A Knowledge-Guided Vision-Language Framework for Age-Friendly Indoor Space Assessment and Design Recommendation**

## 1. Introduction

Population ageing is reshaping housing, community design, health services, and care environments. Older adults often spend a large proportion of time indoors, where environmental quality directly influences safety, accessibility, independence, comfort, and quality of life. Many age-friendly environment problems are not abstract policy problems but concrete spatial problems: narrow circulation paths, insufficient turning space, unsafe bathrooms, poor lighting, unsuitable furniture layout, lack of handrails, cluttered entrances, and poor access to daily services.

Traditional age-friendly environment assessments rely on manual inspection, expert judgement, and checklist-based evaluation. These approaches are valuable but time-consuming and difficult to scale. At the same time, recent developments in artificial intelligence, especially vision-language models, have created opportunities for systems that can interpret images, reason over design criteria, and generate natural-language explanations. However, general-purpose AI models often lack domain grounding. They may recognize objects but fail to assess whether an indoor environment is safe, accessible, and suitable for older adults.

This proposal aims to develop a knowledge-guided vision-language framework for age-friendly indoor space assessment and design recommendation. The project will combine domain knowledge from age-friendly design and built environment research with AI-based visual interpretation and explainable recommendation generation.

## 2. Problem Statement

Current AI-based indoor scene understanding research is strong in object detection, segmentation, 3D reconstruction, and navigation. Yet these methods are often not designed to evaluate age-friendly design quality or to provide actionable renovation recommendations. Conversely, built environment research has developed many age-friendly assessment frameworks, but these frameworks are typically not operationalized as AI-assisted computational systems.

This creates a methodological gap: there is no lightweight, explainable, and domain-guided AI framework that can help identify age-friendly indoor spatial risks from visual inputs and translate them into design recommendations. For applicants and researchers with built environment backgrounds, this gap also provides a meaningful pathway into computer science research through applied AI, HCI, software technology, knowledge representation, and multimodal assessment.

## 3. Research Aim

The aim of this research is to develop and validate a knowledge-guided vision-language framework that can identify age-friendly indoor space risks, explain the reasoning behind assessments, and generate practical design recommendations.

## 4. Research Objectives

1. To build a structured knowledge base of age-friendly indoor spatial risk factors and design intervention principles.
2. To design a multimodal AI workflow that uses vision-language models and supporting computer vision tools for spatial assessment.
3. To integrate rule-guided reasoning with VLM outputs to improve consistency, explainability, and domain relevance.
4. To develop a prototype system for age-friendly indoor space assessment and design recommendation.
5. To evaluate the system using expert assessment and a small-scale set of real residential/community/care environment cases.

## 5. Research Questions

1. How can age-friendly indoor environment knowledge be represented as a structured risk taxonomy and design recommendation knowledge base?
2. To what extent can vision-language models identify age-friendly spatial risks from indoor images or simple spatial information?
3. Does knowledge guidance improve the reliability and usefulness of VLM-based spatial assessment compared with generic VLM prompting?
4. How do experts evaluate the accuracy, explainability, and practical usefulness of AI-generated design recommendations?
5. What prototype workflow is most suitable for translating AI-assisted spatial assessment into design decision support?

## 6. Literature Context

The proposed study sits at the intersection of computer science and built environment research.

In computer science, relevant areas include vision-language models, computer vision, human-computer interaction, knowledge-guided AI, explainable AI, and decision-support systems. Vision-language models have shown strong potential for interpreting visual scenes with text-based reasoning, but their reliability in specialized domains remains a challenge. Knowledge-guided approaches and retrieval-augmented reasoning can help constrain model outputs and improve practical usefulness.

In built environment research, age-friendly design, universal design, accessibility assessment, fall-risk prevention, and evidence-based environmental evaluation provide strong domain knowledge. However, these frameworks are often used manually and are rarely integrated with AI-based visual assessment. The applicant's previous work has developed AI-assisted age-friendly and community resilience assessment frameworks using NLP, SciBERT, contrastive learning, hyperbolic embedding, LSTM, GANs, and random forest regression. This PhD proposal extends that trajectory into a more explicitly computer science-oriented framework.

## 7. Proposed Methodology

### 7.1 Overall Research Design

The research will use a design science approach. It will produce an artifact: a knowledge-guided AI framework and prototype system. The framework will be evaluated through expert judgement, comparative assessment, and case-based validation.

### 7.2 Stage 1: Knowledge Base and Risk Taxonomy

The first stage will construct a structured knowledge base for age-friendly indoor space assessment. Sources may include academic literature, accessibility guidelines, universal design principles, age-friendly housing criteria, interior design standards, fall-prevention guidelines, and the applicant's previous research outputs.

The knowledge base will include categories such as:

- Circulation and access
- Bathroom and toilet safety
- Bedroom and transfer safety
- Kitchen usability
- Lighting and visibility
- Furniture layout and clutter
- Handrails and support features
- Thresholds, steps, and level changes
- Caregiving operation space
- Cognitive and wayfinding support

Each category will contain risk indicators, visual cues, severity levels, and potential design interventions.

### 7.3 Stage 2: Vision-Language Assessment Workflow

The second stage will design the AI assessment workflow. The system may use:

- Vision-language models for image interpretation and explanation
- Object detection or segmentation tools for identifying key features
- Depth estimation or simple spatial measurement support where feasible
- Prompt templates and structured output schemas
- Rule-based validation and checklist alignment

The workflow will not depend on training a large model from scratch. Instead, it will use existing AI models and focus on domain adaptation, structured reasoning, and evaluation.

### 7.4 Stage 3: Knowledge-Guided Reasoning and Recommendation

The third stage will integrate the visual assessment outputs with the knowledge base. The system will map observed risks to design rules and generate recommendations such as:

- Remove or relocate obstacles
- Improve lighting along night-time paths
- Add grab bars in bathrooms
- Increase circulation clearance
- Adjust furniture layout
- Reduce threshold risks
- Improve caregiving operation space
- Prioritize interventions by severity and feasibility

The system output will include risk category, risk evidence, severity level, design recommendation, and explanation.

### 7.5 Stage 4: Prototype Development

A prototype interface will be developed for demonstration and evaluation. The applicant's existing **China Age-Friendly Community Assessment Map** will serve as an AI/CS portfolio foundation. It demonstrates a web-based assessment interface, community scoring, map visualization, multi-dimensional indicators, and interactive reporting. The PhD prototype will extend this logic toward indoor spatial assessment and recommendation.

Existing demo:

- Website: https://wenquan0816.github.io/age-friendly-community-map/
- Repository: https://github.com/WENQUAN0816/age-friendly-community-map

### 7.6 Stage 5: Evaluation

Evaluation will include:

- Expert assessment of risk identification accuracy
- Expert rating of recommendation usefulness
- Comparison between generic VLM prompting and knowledge-guided prompting
- Consistency analysis for repeated expert annotation
- Usability feedback from design or built environment experts

Evaluation metrics may include accuracy, precision/recall for risk categories where labels are available, inter-rater agreement, expert usefulness score, explanation quality score, and task completion feedback.

## 8. Expected Dataset

The project will use a lightweight dataset suitable for PhD feasibility.

Minimum feasible version:

- 20-30 residential/community/care environment cases
- 80-150 room or spatial samples
- 300-700 photographs or visual records
- 50-100 expert recommendations

Preferred PhD-scale version:

- 30-50 cases
- 150-250 rooms or spatial samples
- 500-1000 images
- 150-300 expert recommendations
- 2-3 experts for partial repeated evaluation

Public datasets in indoor scene understanding may be used only as supporting references or for baseline experimentation, not as the main contribution.

## 9. Expected Contributions

The expected contributions are:

1. A structured age-friendly indoor spatial risk taxonomy and knowledge base.
2. A knowledge-guided vision-language framework for spatial assessment.
3. A prototype AI decision-support system for design recommendation.
4. Empirical evaluation comparing generic VLM outputs and knowledge-guided outputs.
5. A feasible bridge between computer science, HCI, AI applications, and age-friendly built environment research.

## 10. Significance

The research is significant for both computer science and built environment practice. For computer science, it provides a domain-grounded application of multimodal AI, knowledge-guided reasoning, explainable AI, and HCI evaluation. For built environment research, it provides a scalable pathway for preliminary screening and design decision support in age-friendly housing and care environments.

The project is especially relevant to ageing societies in Asia, including China and Malaysia, where rapid ageing, housing renewal, care infrastructure, and digital transformation are major social and policy challenges.

## 11. Feasibility

The applicant has a completed PhD in Interior Design, a strong publication record in AI-assisted built environment assessment, multiple PI-led age-friendly design projects, and a working web-based demo related to age-friendly community assessment. The project is deliberately designed as a lightweight AI framework rather than a large-scale data collection project. This makes it feasible for a PhD in Computer Science and Technology while still offering methodological contributions.

## 12. Provisional Timeline

### Year 1

- Finalize literature review.
- Build age-friendly indoor spatial risk taxonomy.
- Develop knowledge base and structured assessment schema.
- Prepare initial dataset and expert validation plan.
- Build baseline VLM prompting workflow.

### Year 2

- Develop knowledge-guided VLM workflow.
- Build prototype assessment and recommendation system.
- Collect and organize 20-50 real cases.
- Conduct expert evaluation and refine the system.
- Prepare first journal/conference paper.

### Year 3

- Extend evaluation and comparative experiments.
- Improve system explainability and usability.
- Finalize prototype and documentation.
- Prepare remaining publications.
- Write and submit thesis.

## 13. Ethical Considerations

The study may involve indoor images and expert evaluation. All personal information, identifiable home details, and sensitive location data should be removed or anonymized. If human participants or private homes are involved, informed consent and institutional ethics approval will be obtained. The project will avoid publishing identifiable private spaces without permission.

## 14. Fit with Xiamen University Malaysia

The proposed research fits the PhD in Computer Science and Technology through AI, HCI, software technology, multimodal systems, knowledge representation, and applied computer vision. It can connect with supervisors working in artificial intelligence, computer vision, software engineering, HCI, usability engineering, mixed reality, or intelligent healthcare.

## 15. Selected References to Develop

This draft proposal should be expanded with formal references before final submission. Suggested reference areas:

- Vision-language models and multimodal reasoning
- Knowledge-guided AI and retrieval-augmented generation
- Explainable AI and HCI evaluation
- Indoor scene understanding and spatial intelligence
- Age-friendly housing, universal design, fall-risk prevention
- Design decision-support systems in built environments

