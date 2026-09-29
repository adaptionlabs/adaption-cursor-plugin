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
   - `model`: Base model to fine-tune
   - `column_mapping`: How columns map to training format
   - `hyperparams`: Training configuration (or use recommended)
6. Poll `get_autoscientist_run` with `experiment_id` until complete

### Augment during training

AutoScientist can augment your dataset during training:

```json
{
  "dataset_id": "...",
  "model": "llama-3.1-8b",
  "augmentation_domain_rows": 1000,
  "augmentation_general_rows": 500
}
```

### Check training history

1. Call `list_autoscientist_runs` to see all runs
2. Filter by dataset: `list_autoscientist_runs` with `dataset_id`
3. Get details: `get_autoscientist_run` with `experiment_id`

## Training Configuration

Hyperparameters when creating a run:

```json
{
  "hyperparams": {
    "epochs": 3,
    "learning_rate": 2e-5,
    "batch_size": 8,
    "warmup_ratio": 0.1
  }
}
```

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
