---
name: adaption-training
description: Launch and monitor AutoScientist training runs using Adaption MCP. Use when 
  fine-tuning models, checking training progress, or getting hyperparameter recommendations.
---

# Adaption Training Skill

Launch and monitor AutoScientist training runs on the Adaption platform.

## When to use

- List available base models for fine-tuning
- Get recommended hyperparameters for a dataset
- Launch AutoScientist training runs
- Monitor training progress and iterations
- List past training runs

## Available MCP Tools

| Tool | Description |
|------|-------------|
| `list_training_models` | List base models currently available for AutoScientist training |
| `list_autoscientist_runs` | List AutoScientist runs, optionally filtered to one dataset |
| `get_autoscientist_run` | Poll one AutoScientist run, including iteration progress and failure messages |
| `recommend_autoscientist_hyperparameters` | Resolve suitable model and hyperparameters for a dataset without launching |
| `create_autoscientist_run` | Launch a new asynchronous AutoScientist training run (spends credits) |

## Example Workflows

### Fine-tune a model with AutoScientist

1. Ensure dataset status is `ready` (check with `get_dataset_status`)
2. Call `list_training_models` to see available base models
3. Call `recommend_autoscientist_hyperparameters` with:
   - `dataset_id`: Your ready dataset
   - `model`: Optional preferred base model
4. Review recommended configuration
5. Call `create_autoscientist_run` with:
   - `dataset_id`: Your ready dataset
   - `model`: Optional base model — the platform picks one when omitted
   - `column_mapping`: Optional, see below — inferred from the dataset when omitted
   - `hyperparams`: Optional training configuration, or use the recommended one
6. Poll `get_autoscientist_run` with `experiment_id` until complete

## Column mapping

A training run accepts a different set of roles than dataset adaptation does, and
unknown keys are dropped silently instead of rejected — so `context`, `chat`, or
`image` sent here are ignored without an error.

| Role | Use |
|------|-----|
| `prompt` | Column holding the instruction text |
| `completion` | Column holding the target response |
| `reasoning_trace` | Column holding a reasoning trace, when the dataset has one |
| `chosen` | Preferred completion, alignment runs only |
| `rejected` | Rejected completion, alignment runs only |

Omit `column_mapping` entirely and AutoScientist infers it from the dataset.

### Augment during training

AutoScientist can augment your dataset during training:

```json
{
  "dataset_id": "...",
  "augmentation_domain_rows": 1000,
  "augmentation_general_rows": 500
}
```

### Check training history

1. Call `list_autoscientist_runs` to see all runs
2. Filter by dataset: `list_autoscientist_runs` with `dataset_id`
3. Get details: `get_autoscientist_run` with `experiment_id`

## Training Configuration

`hyperparams` is validated strictly, so an unknown key fails the whole request.
Every field is optional — omit what you do not want to pin and AutoScientist
fills it in from the recommendation.

```json
{
  "hyperparams": {
    "training_type": "lora",
    "n_epochs": 3,
    "learning_rate": 2e-5,
    "batch_size": "max",
    "lora_r": 16,
    "lora_alpha": 32,
    "lr_scheduler_type": "cosine",
    "warmup_ratio": 0.1
  }
}
```

| Parameter | Accepted values |
|-----------|-----------------|
| `training_type` | `lora` or `full` — LoRA versus full fine-tuning |
| `n_epochs` | 1-20 |
| `learning_rate` | 1e-8 to 1e-2 |
| `batch_size` | `"max"` or a positive integer |
| `lora_r` | 1-64 |
| `lora_alpha` | Must equal `lora_r` or twice `lora_r` |
| `lora_dropout` | 0-1 |
| `lora_trainable_modules` | `"all-linear"` or a comma-separated module list |
| `lr_scheduler_type` | `linear`, `cosine`, or `constant` |
| `min_lr_ratio` | 0-1 |
| `scheduler_num_cycles` | 0-4 |
| `warmup_ratio` | 0-1 |
| `max_grad_norm` | Non-negative |
| `weight_decay` | Non-negative |
| `train_on_inputs` | Boolean |
| `dpo_beta` | 0.05-0.9, alignment runs only |
| `dpo_normalize_logratios_by_length` | Boolean, alignment runs only |
| `rpo_alpha`, `simpo_gamma` | Alignment runs only, and both cannot be positive at once |

## Training Status

The `get_autoscientist_run` response includes:
- Current status and iteration progress
- Training metrics per iteration
- Public failure message if failed

## Tips

- Use `recommend_autoscientist_hyperparameters` before launching to optimize configuration
- Training runs consume credits — verify dataset is ready first
- Poll `get_autoscientist_run` every 30-60 seconds during training
- Include `augmentation_domain_rows` for domain-specific data enrichment
