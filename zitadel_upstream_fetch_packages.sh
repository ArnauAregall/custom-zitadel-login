#!/bin/bash

# Configurable variables
UPSTREAM_REPO="https://github.com/zitadel/zitadel.git"
UPSTREAM_BRANCH="remove-turbo-2"
TMP_DIR="tmp_upstream_zitadel"

echo "Fetching packages from '$UPSTREAM_REPO', branch '$UPSTREAM_BRANCH'..."

# Remove temp dir if exists
rm -rf "$TMP_DIR"

# Clone upstream into temp dir
git clone --depth 1 --branch "$UPSTREAM_BRANCH" "$UPSTREAM_REPO" "$TMP_DIR"

# Sync packages directory from upstream
rsync -a \
  --exclude '.git' \
  "$TMP_DIR/packages/" "packages/"

# Clean up temp dir
rm -rf "$TMP_DIR"

echo "✅ 'packages/' directory updated from upstream"
