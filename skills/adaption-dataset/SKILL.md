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

1. Call `import_dataset` with a `source` object — all import options nest inside it:
   ```json
   {
     "source": {
       "url": "https://huggingface.co/datasets/squad",
       "files": ["plain_text/train-00000-of-00001.parquet"]
     }
   }
   ```
   `files` is required for HuggingFace and Kaggle imports and rejected for Google
   Sheets. Pass `processing_mode: "raw"` to import a trainable dataset without
   running Adaptive Data.
2. Poll `get_dataset_status` until processing completes
3. Call `run_dataset_adaptation` with `estimate: true` to preview cost
4. Call `run_dataset_adaptation` with column mapping to launch
5. Poll `get_dataset_status` until adaptation completes
6. Call `get_dataset_export_links` to download results

### Augment a dataset with synthetic data

1. Ensure source dataset status is `ready`
2. Call `augment_dataset` with:
   - `dataset_id`: Source dataset ID
   - `domain_rows`: More samples from the domain already present in the dataset
   - `general_rows`: Samples from other domains not present in it
   - `training_type`: `instruction_dataset` (default) or `preference_pairs`
   - `estimate: true` for cost preview
3. Launch with `estimate: false`
4. Poll `get_dataset_status` on the new dataset ID

Each row count tops out at 100,000 per strategy. Augmenting creates a new dataset
rather than modifying the source.

### Translate dataset to multiple languages

1. Call `translate_dataset` with:
   - `dataset_id`: Source dataset ID
   - `languages`: Array of target language codes
   - `sample_rate`: Share of rows to translate, between 0.01 and 1
   - `estimate: true` for cost preview
2. Poll `get_dataset_status` until translation completes

`localize_dataset` takes the same `sample_rate` but replaces `languages` with
`pairs`, an array of `{ "country": "RS", "language": "sr" }` objects.

### Combine multiple datasets

1. Ensure all source datasets have compatible schemas and status `ready`
2. Call `combine_datasets` with:
   - `dataset_ids`: 2 to 10 unique dataset IDs, each a UUID v4
   - `name`: Required name for the combined dataset
   - `idempotency_key`: Required — reusing the same key returns the same result
     instead of combining twice

All sources must belong to the same organization.

## Column Mapping

When calling `run_dataset_adaptation`, map dataset columns to roles. Full rules: https://docs.adaptionlabs.ai/adaptive-data/select-columns/

- `prompt` and `completion` are column names. At least one is required. If the other is missing, Adaptive Data generates it.
- `context` is a list of column names (background or metadata), not a single string.
- `image` is one column of image bytes, URLs, or paths. Do not put images in `context`.
- `chat` is one column of multi-turn message arrays. It replaces `prompt`, `completion`, and `context`.
- `universal_prompt` is a shared instruction string for every row, not a column name. Use it when the dataset has no prompt column. It requires `context` or `image` to vary each row, and is mutually exclusive with `prompt`.

```json
{
  "column_mapping": {
    "prompt": "question",
    "completion": "answer",
    "context": ["category", "source"]
  }
}
```

## Adaptation Options

Beyond `column_mapping`, `run_dataset_adaptation` accepts:

| Parameter | Description |
|-----------|-------------|
| `training_type` | `instruction_dataset` (default) or `preference_pairs`. Use `preference_pairs` to prepare a dataset for an alignment training run |
| `recipe_specification` | Toggles for `prompt_rephrase`, `deduplication`, and `reasoning_traces` under a `recipes` object |
| `brand_controls` | `length` (`minimal`, `concise`, `detailed`, `extensive`), `safety_categories`, `hallucination_mitigation`, and `blueprint` |
| `job_specification` | `max_rows` to cap the run, plus `idempotency_key` |
| `language_expansion` | Same `translate`/`localize` spec as dataset generation |
| `estimate` | Set `true` to preview cost without launching |

## Tips

- Use `estimate: true` parameter to preview costs before launching operations
- Poll `get_dataset_status` every 5-10 seconds during processing — it returns
  `progress_percentage` alongside the status
- Filter `list_datasets` with `status` (`pending`, `running`, `awaiting_input`,
  `succeeded`, `failed`) or a `query` string instead of paging through everything
- Launch responses carry a `next_action` naming the tool to call next — follow it
- Check `get_dataset_evaluation` for quality metrics after adaptation
- Use `idempotency_key` for safe retries on launch operations
