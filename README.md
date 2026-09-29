# Adaption Plugin for Cursor

Connect Cursor to [Adaption](https://adaptionlabs.ai) for dataset management, fine-tuning, and AutoScientist workflows.

## Installation

### From Cursor Marketplace

1. Open **Cursor Settings** → **Plugins**
2. Search for **"adaption"**
3. Click **Install**
4. Enter your **Adaption API Key** when prompted
5. Restart Cursor

### Manual Installation

```bash
git clone https://github.com/adaptionlabs/adaption-cursor-plugin.git
```

Then in Cursor: **Settings** → **Plugins** → **Install from path** → select the cloned directory.

### Get Your API Key

1. Go to [app.adaptionlabs.ai/settings/api-keys](https://app.adaptionlabs.ai/settings/api-keys)
2. Create a new API key with `adaption-mcp:read` and `adaption-mcp:write` scopes
3. Copy the key and enter it in the plugin configuration

## Features

### 📊 Dataset Management

- Upload datasets (CSV, JSON, Parquet)
- Import from HuggingFace or Kaggle
- Launch adaptation pipelines
- Download processed results

### 🎯 Fine-tuning

- Browse available base models
- Launch training jobs
- Monitor training progress

### 🔬 AutoScientist

- Generate synthetic datasets
- Run Invent workflows for domain-specific data
- Optimize data quality automatically

## Available Skills

| Skill | Description |
|-------|-------------|
| `adaption-dataset` | Dataset upload, processing, and adaptation |
| `adaption-training` | Fine-tuning job management |
| `adaption-autoscientist` | Synthetic data generation and optimization |

## Example Usage

Once installed, you can interact with Adaption through natural conversation:

> "Upload my training_data.csv and adapt it for fine-tuning"

> "Start fine-tuning llama-3.1-8b on my adapted dataset"

> "Generate 1000 customer service examples using AutoScientist"

> "Check the status of my training job"

## Requirements

- Cursor IDE
- Adaption account with API access
- API key with MCP scopes

## Support

- **Documentation**: [docs.adaptionlabs.ai](https://docs.adaptionlabs.ai)
- **Issues**: [GitHub Issues](https://github.com/adaptionlabs/adaption-cursor-plugin/issues)
- **Email**: support@adaptionlabs.ai

## License

MIT License - see [LICENSE](LICENSE) for details.
