#!/bin/bash

# Configurable variables
UPSTREAM_REPO="https://github.com/zitadel/zitadel.git"
UPSTREAM_BRANCH="remove-turbo-2"
UPSTREAM_DIR="apps/login"
TMP_DIR="tmp_upstream_zitadel"

echo "⚙️ Updating repository root from '$UPSTREAM_REPO', branch '$UPSTREAM_BRANCH', directory '$UPSTREAM_DIR'..."

# Remove temp dir if exists
rm -rf "$TMP_DIR"

# Clone upstream into temp dir
git clone --depth 1 --branch "$UPSTREAM_BRANCH" "$UPSTREAM_REPO" "$TMP_DIR"

# Sync root directory from upstream apps/login
rsync -a \
  --exclude 'node_modules' \
  --exclude '.next' \
  --exclude '.git' \
  --exclude 'packages' \
  --exclude '.gitignore' \
  --exclude 'update_upstream.sh' \
  "$TMP_DIR/$UPSTREAM_DIR/" "./"

# Sync packages/zitadel-proto from upstream
rsync -a \
  --exclude 'node_modules' \
  --exclude '.git' \
  "$TMP_DIR/packages/zitadel-proto/" "packages/zitadel-proto/"

# Sync packages/zitadel-client from upstream
rsync -a \
  --exclude 'node_modules' \
  --exclude '.git' \
  "$TMP_DIR/packages/zitadel-client/" "packages/zitadel-client/"

# Clean up temp dir
rm -rf "$TMP_DIR"

echo "✅ Repository root and packages updated from upstream"
