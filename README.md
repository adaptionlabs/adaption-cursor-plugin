# Adaption Plugin for Cursor

Connect Cursor to [Adaption](https://adaptionlabs.ai) for dataset management, fine-tuning, and AutoScientist workflows.

## Installation

Pick the method that matches what you are doing:

| Method | Use when |
|--------|----------|
| [Cursor Marketplace](#from-the-cursor-marketplace) | The plugin is published. One click, Cursor handles updates. |
| [Git repository](#from-the-git-repository) | Rolling it out to a team before it is public. |
| [Local checkout](#local-development) | Developing or testing changes that are not pushed yet. |

Cursor resolves plugin sources through Git, so the first two methods install a
**committed and pushed** revision. A working tree on disk is only picked up by
the local-checkout method below.

### From the Cursor Marketplace

1. Open **Customize** in the sidebar
2. Search for **"adaption"**
3. Click **Install**
4. **Configure** → set `ADAPTION_API_KEY`

### From the Git repository

Import the repository as a team marketplace — this is the recommended way to
install the plugin from source:

1. Open **Dashboard → Plugins & MCPs**
2. Under **Team Marketplaces**, click **Add Marketplace** → **Import from Repo**
3. Paste `https://github.com/adaptionlabs/adaption-cursor-plugin`
4. Add the `adaption` plugin, set **Marketplace Access**, and save
5. In Cursor, open **Customize**, find **adaption**, and click **Install**
6. **Configure** → set `ADAPTION_API_KEY`

Cursor indexes a single commit from the branch the marketplace tracks. Push your
changes and click **Refresh** (or enable **Auto Refresh**) before expecting them
to appear.

### Local development

> Do not add the repository folder as a plugin source in **Customize**. Cursor
> stages plugin sources with a `git init` and fetch, which yields nothing for a
> plain directory. The plugin card still renders from the manifest, so it looks
> installed, but the plugin payload is empty: no skills and no MCP server. The
> plugin log reports `0 plugins loaded, 0 failures` with no visible error.

The supported way to load an unpublished checkout is Cursor's local plugin
directory, `~/.cursor/plugins/local`:

```bash
./scripts/install-local.sh
```

The script copies this checkout to `~/.cursor/plugins/local/adaption`. It copies
rather than symlinks on purpose — Cursor skips symlinks whose target resolves
outside that directory.

Then:

1. Run **Developer: Reload Window**
2. **Customize → adaption → Configure** and set `ADAPTION_API_KEY`
3. Under **MCP servers**, confirm `adaption` is connected

Re-run the script and reload the window after every change. MCP servers do not
hot-reload.

Until `ADAPTION_API_KEY` holds a valid key, the server fails with
`403 Only API keys are permitted on this endpoint` and exposes no tools. The
endpoint accepts an Adaption API key only — not a session or OAuth token.

Both `mcp.json` and `.cursor-plugin/plugin.json` ship the production endpoint. To
test against dev, point `url` at `https://api.dev.adaptionlabs.ai/api/v1/mcp` in
both files before running the script, and revert before committing.

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
