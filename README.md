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
2. Create a new API key
3. Copy the key and enter it in the plugin configuration

## Features

### 📊 Dataset Management

- Import datasets from HuggingFace, Kaggle, or Google Sheets
- Run adaptation pipelines
- Augment, translate, and localize datasets
- Combine multiple datasets
- Export processed results

### 🎯 Fine-tuning

- Browse available base models
- Launch training jobs
- Monitor training progress

### 🔬 Invent

- Generate synthetic training datasets
- Explore available domains and subdomains
- Create domain-specific data from specifications

## Available Skills

| Skill | Description |
|-------|-------------|
| `adaption-dataset` | Dataset import, processing, and transformation |
| `adaption-training` | AutoScientist training runs |
| `adaption-invent` | Synthetic data generation |

## Example Usage

Once installed, you can interact with Adaption through natural conversation:

> "Import this HuggingFace dataset and adapt it for fine-tuning"

> "Start fine-tuning llama-3.1-8b on my adapted dataset"

> "Generate 1000 customer service examples using Invent"

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
