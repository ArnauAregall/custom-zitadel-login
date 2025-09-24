#!/bin/bash

# Configurable variables
UPSTREAM_REPO="https://github.com/zitadel/zitadel.git"
UPSTREAM_BRANCH="remove-turbo-2"
TMP_DIR="tmp_upstream_zitadel"

echo "Fetching proto files from '$UPSTREAM_REPO', branch '$UPSTREAM_BRANCH'..."

# Ensure proto directory exists
if [ ! -d "proto" ]; then
  mkdir proto
  echo "Created 'proto/' directory at project root."
else
  echo "'proto/' directory already exists."
fi

# Add proto/ to .gitignore if not present
if ! grep -qxF "proto/" .gitignore; then
  echo "proto/" >> .gitignore
  echo "Added 'proto/' to .gitignore."
else
  echo "'proto/' already listed in .gitignore."
fi

# Remove temp dir if exists
rm -rf "$TMP_DIR"

# Clone upstream into temp dir
git clone --depth 1 --branch "$UPSTREAM_BRANCH" "$UPSTREAM_REPO" "$TMP_DIR"

# Sync proto directory from upstream
rsync -a \
  --exclude '.git' \
  "$TMP_DIR/proto/" "proto/"

# Clean up temp dir
rm -rf "$TMP_DIR"

echo "✅ 'proto/' directory updated from upstream and gitignored"
