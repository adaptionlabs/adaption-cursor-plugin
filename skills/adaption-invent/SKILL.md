---
name: adaption-invent
description: Generate synthetic datasets using Adaption Invent. Use when creating 
  AI-generated training data from domain specifications.
---

# Adaption Invent Skill

Generate synthetic training datasets using the Adaption Invent system.

## When to use

- Generate synthetic training datasets from specifications
- Explore available domains and subdomains for data generation
- Create domain-specific datasets without source data
- Estimate costs before generating data

## Available MCP Tools

| Tool | Description |
|------|-------------|
| `list_invent_domains` | List valid domain and qualified subdomain codes for dataset generation |
| `generate_dataset` | Estimate or launch generation of a new invented dataset (launches consume credits) |

After generation starts, use dataset tools to track progress:
| Tool | Description |
|------|-------------|
| `get_dataset_status` | Poll processing status of the generated dataset |
| `get_dataset` | Get details of the generated dataset |

## Example Workflows

### Generate domain-specific training data

1. Call `list_invent_domains` to explore available domains and subdomains
2. Choose domain and subdomain codes matching your use case
3. Call `generate_dataset` with `estimate: true` to preview cost:
   ```json
   {
     "domains": ["technology"],
     "subdomains": ["software_development"],
     "rows": 1000,
     "estimate": true
   }
   ```
4. Review estimate, then launch with `estimate: false`
5. Poll `get_dataset_status` with returned dataset ID until complete
6. Generated dataset is ready for adaptation and training

### Generate with custom specifications

```json
{
  "name": "Customer Support QA",
  "training_type": "chat",
  "domains": ["business"],
  "subdomains": ["customer_service"],
  "rows": 500,
  "dataset_prompt": "Generate realistic customer questions about technical software product support scenarios"
}
```

### Generate with language expansion

```json
{
  "domains": ["education"],
  "subdomains": ["tutoring"],
  "rows": 1000,
  "language_expansion": {
    "languages": ["es", "fr", "de"],
    "rows_per_language": 200
  }
}
```

## Domain Categories

Domains span many categories including:

- **Technology**: Software development, APIs, DevOps, data science
- **Business**: Customer service, sales, marketing, operations
- **Science**: Research methodology, analysis, experiments
- **Education**: Tutoring, explanations, assessments, curricula
- **Creative**: Writing, content creation, storytelling

Use `list_invent_domains` to see the full catalog with qualified subdomain codes.

## Parameters

| Parameter | Description |
|-----------|-------------|
| `name` | Optional name for the generated dataset |
| `training_type` | Training format (e.g., `chat`, `completion`) |
| `domains` | Required array of domain codes |
| `subdomains` | Optional array of subdomain codes |
| `rows` | Required number of rows to generate |
| `language_expansion` | Optional multi-language generation config |
| `dataset_prompt` | Optional generation guidance for the dataset |
| `estimate` | Set `true` to preview cost without launching |
| `idempotency_key` | Optional key for safe retries |

## Tips

- Start with smaller row counts (100-500) to validate quality
- Use a specific `dataset_prompt` for better results
- Generated data works best when combined with real examples via `augment_dataset`
- Use `estimate: true` to check credits before launching
- Use `idempotency_key` for safe retries if generation fails
