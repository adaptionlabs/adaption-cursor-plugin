---
name: adaption-dataset
description: Import, process, and transform datasets using Adaption MCP. Use when importing 
  datasets, running adaptation, augmenting, translating, localizing, or combining datasets.
---

# Adaption Dataset Skill

Import, process, and transform datasets using the Adaption platform.

## When to use

- Import datasets from HuggingFace, Kaggle, or Google Sheets
- Run dataset adaptation pipeline
- Augment datasets with synthetic domain/general rows
- Translate or localize dataset content
- Combine multiple datasets
- Check processing status and download results

## Available MCP Tools

Use these tools via the Adaption MCP server:

| Tool | Description |
|------|-------------|
| `list_datasets` | List datasets visible to the authenticated Adaption organization |
| `get_dataset` | Get a concise public view of one dataset, including processing and column information |
| `get_dataset_status` | Poll dataset processing status and progress after async operations |
| `get_dataset_evaluation` | Get quality evaluation status and results for one dataset |
| `get_dataset_export_links` | Poll saved external export URLs for a dataset after export |
| `import_dataset` | Import a dataset from HuggingFace, Kaggle, or Google Sheets URL |
| `run_dataset_adaptation` | Estimate or launch adaptation for an imported dataset |
| `augment_dataset` | Create new dataset with source rows plus curated domain/general rows |
| `translate_dataset` | Create new dataset with sampled rows translated into target languages |
| `localize_dataset` | Create new dataset with rows localized for country/language pairs |
| `combine_datasets` | Combine compatible ready datasets into one new dataset |

## Example Workflows

### Import and adapt a HuggingFace dataset

1. Call `import_dataset` with HuggingFace URL
2. Poll `get_dataset_status` until processing completes
3. Call `run_dataset_adaptation` with `estimate: true` to preview cost
4. Call `run_dataset_adaptation` with column mapping to launch
5. Poll `get_dataset_status` until adaptation completes
6. Call `get_dataset_export_links` to download results

### Augment a dataset with synthetic data

1. Ensure source dataset status is `ready`
2. Call `augment_dataset` with:
   - `dataset_id`: Source dataset ID
   - `domain_rows`: Number of domain-specific rows to add
   - `general_rows`: Number of general rows to add
   - `estimate: true` for cost preview
3. Launch with `estimate: false`
4. Poll `get_dataset_status` on the new dataset ID

### Translate dataset to multiple languages

1. Call `translate_dataset` with:
   - `dataset_id`: Source dataset ID
   - `languages`: Array of target language codes
   - `sample_size`: Number of rows to translate
2. Poll `get_dataset_status` until translation completes

### Combine multiple datasets

1. Ensure all source datasets have compatible schemas and status `ready`
2. Call `combine_datasets` with array of dataset IDs
3. Use `idempotency_key` to prevent duplicate combinations

## Column Mapping

When running adaptation, specify how columns map to training format:

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

- Use `estimate: true` parameter to preview costs before launching operations
- Poll `get_dataset_status` every 5-10 seconds during processing
- Check `get_dataset_evaluation` for quality metrics after adaptation
- Use `idempotency_key` for safe retries on launch operations
