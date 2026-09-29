---
name: adaption-dataset
description: Upload, process, and adapt datasets using Adaption. Use when creating 
  new datasets, launching adaptation pipelines, checking status, or downloading results.
---

# Adaption Dataset Skill

Upload, process, and adapt datasets using the Adaption platform.

## When to use

- Upload a new dataset (CSV, JSON, Parquet)
- Import datasets from HuggingFace or Kaggle
- Launch dataset adaptation pipeline
- Check dataset processing status
- Download adapted datasets

## Available MCP Tools

Use these tools via the Adaption MCP server:

| Tool | Description |
|------|-------------|
| `adaption_create_dataset` | Create a dataset and get presigned upload URL |
| `adaption_complete_upload` | Mark upload as complete, trigger processing |
| `adaption_launch_adaptation` | Start the adaptation pipeline with column mapping |
| `adaption_get_dataset_status` | Check processing status and progress |
| `adaption_list_datasets` | List all datasets in organization |
| `adaption_download_dataset` | Get download URL for adapted results |

## Example Workflows

### Upload and adapt a local CSV file

1. Call `adaption_create_dataset` with file name and format
2. Upload file to the returned presigned URL using PUT request
3. Call `adaption_complete_upload` to trigger processing
4. Wait for processing to complete (poll `adaption_get_dataset_status`)
5. Call `adaption_launch_adaptation` with column mapping:
   - `prompt`: column containing prompts/inputs
   - `completion`: column containing expected outputs
   - `context`: optional context columns
6. Poll `adaption_get_dataset_status` until adaptation completes
7. Call `adaption_download_dataset` to get results

### Import from HuggingFace

1. Call `adaption_create_dataset` with HuggingFace URL
2. Processing starts automatically
3. Continue from step 5 above

## Column Mapping

When launching adaptation, specify how your dataset columns map to the training format:

```json
{
  "column_mapping": {
    "prompt": "question",
    "completion": "answer",
    "context": ["category", "source"]
  }
}
```

## Tips

- Poll status every 5-10 seconds during processing
- Adaptation time depends on dataset size (estimate provided in response)
- Use `estimate: true` to get cost estimate before launching
