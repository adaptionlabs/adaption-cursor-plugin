---
name: adaption-training
description: Launch and monitor fine-tuning jobs using Adaption. Use when starting 
  training runs, checking training status, or managing fine-tuned models.
---

# Adaption Training Skill

Launch and monitor fine-tuning jobs on the Adaption platform.

## When to use

- Start a fine-tuning job on an adapted dataset
- Monitor training progress and metrics
- List available base models for fine-tuning
- Manage and deploy fine-tuned models

## Available MCP Tools

| Tool | Description |
|------|-------------|
| `adaption_list_models` | List available base models for fine-tuning |
| `adaption_launch_training` | Start a fine-tuning job on a dataset |
| `adaption_get_training_status` | Check training progress and metrics |
| `adaption_list_training_jobs` | List all training jobs in organization |

## Example Workflows

### Fine-tune a model on adapted data

1. Ensure dataset is adapted (status: `succeeded`)
2. Call `adaption_list_models` to see available base models
3. Call `adaption_launch_training` with:
   - `dataset_id`: ID of the adapted dataset
   - `base_model`: Model to fine-tune (e.g., `llama-3.1-8b`)
   - `hyperparameters`: Optional training configuration
4. Poll `adaption_get_training_status` until training completes
5. Model is ready for deployment

## Training Configuration

Optional hyperparameters when launching training:

```json
{
  "hyperparameters": {
    "epochs": 3,
    "learning_rate": 2e-5,
    "batch_size": 8
  }
}
```

## Training Status Values

| Status | Description |
|--------|-------------|
| `queued` | Job is waiting to start |
| `running` | Training in progress |
| `succeeded` | Training completed successfully |
| `failed` | Training failed (check error message) |

## Tips

- Training time depends on dataset size and model
- Monitor loss metrics in status response
- Larger datasets generally produce better models
- Use the estimate endpoint to check costs before launching
