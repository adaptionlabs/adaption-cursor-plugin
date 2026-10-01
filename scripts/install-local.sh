#!/usr/bin/env bash
# Install this checkout into Cursor's local plugin directory.
# Cursor reads that directory directly. Adding the repo folder from
# Customize → Plugins does not load the MCP server.
set -euo pipefail

root="$(cd "$(dirname "$0")/.." && pwd)"
dest="${HOME}/.cursor/plugins/local/adaption"

mkdir -p "$dest"
rsync -a --delete \
  --exclude .git \
  --exclude .idea \
  --exclude scripts \
  "$root/" "$dest/"

echo "Installed to $dest"
echo "In Cursor: Developer: Reload Window"
echo "Then Plugins → adaption → Configure, and set ADAPTION_API_KEY."
echo "The MCP server name is adaption."
