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
     "subdomains": ["technology.software_applications"],
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
  "training_type": "instruction_dataset",
  "domains": ["corporate_business"],
  "subdomains": ["corporate_business.customer_service"],
  "rows": 500,
  "dataset_prompt": "Generate realistic customer questions about technical software product support scenarios"
}
```

### Generate with language expansion

`language_expansion` is either a `translate` or a `localize` spec, and `type` is
required. `sample_rate` (0.01-1) is the share of rows expanded. Credits are
billed on the post-expansion row count, so this quotes above `rows`.

```json
{
  "domains": ["academic_education"],
  "subdomains": ["academic_education.stem"],
  "rows": 1000,
  "language_expansion": {
    "type": "translate",
    "languages": ["es", "fr", "de"],
    "sample_rate": 0.2
  }
}
```

To localize for country/language pairs instead:

```json
{
  "language_expansion": {
    "type": "localize",
    "pairs": [{ "country": "RS", "language": "sr" }],
    "sample_rate": 0.2
  }
}
```

## Domains and subdomains

Domain codes are flat lowercase strings such as `technology`, `medical`, `legal`,
`code`, `corporate_business`, `academic_education`, and `personal_finance`.
Subdomain codes are always qualified with their domain as `domain.subdomain`,
for example `medical.symptoms_diagnosis` — a bare code can belong to more than
one domain, so an unqualified value is rejected.

Call `list_invent_domains` for the full catalog with the exact codes. A subdomain
naming a domain that is not in your `domains` array is rejected rather than
silently added.

## Parameters

`rows` is always required, plus at least one of `dataset_prompt`, `domains`, or
`subdomains`. With both taxonomy fields omitted, `dataset_prompt` is required and
the taxonomy is inferred from it; if nothing can be inferred the request is
rejected rather than generating across every domain. Supplying `domains` or
`subdomains` disables that inference.

| Parameter | Description |
|-----------|-------------|
| `rows` | Required number of rows to generate, subject to your plan's per-launch cap |
| `dataset_prompt` | Free-text description of the data you want, up to 10,000 characters |
| `domains` | Optional array of domain codes |
| `subdomains` | Optional array of qualified `domain.subdomain` codes |
| `training_type` | Shape of the generated data: `instruction_dataset` (default) or `preference_pairs` |
| `name` | Optional name for the generated dataset, up to 255 characters |
| `language_expansion` | Optional `translate` or `localize` expansion config |
| `estimate` | Set `true` to preview cost without launching |
| `idempotency_key` | Optional key for safe retries |

`training_type` here is the shape of the DATA, not the training method:
`instruction_dataset` produces prompt/completion rows, `preference_pairs`
produces ranked completion pairs. The `training_type` inside `hyperparams` on a
training run is a different field meaning LoRA versus full fine-tuning.

Generate with `preference_pairs` when the dataset will feed an alignment training
run — see the `adaption-training` skill, where that run needs
`training_method: "alignment"`.

## Tips

- Start with smaller row counts (100-500) to validate quality
- Use a specific `dataset_prompt` for better results
- Generated data works best when combined with real examples via `augment_dataset`
- Use `estimate: true` to check credits before launching
- Launch responses carry a `next_action` naming the tool to call next — follow it
- Use `idempotency_key` for safe retries if generation fails
