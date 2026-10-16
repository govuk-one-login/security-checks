#!/usr/bin/env bash
set -euo pipefail

: "${BRANCH:?BRANCH is required}"
: "${RUN_ID:?RUN_ID is required}"
: "${REPOSITORY:?REPOSITORY is required}"
: "${SHA:?SHA is required}"
: "${PR_TYPE:?PR_TYPE is required}"

PR_URL=$(gh pr create \
  --repo "${TARGET_REPO}" \
  --title "DO NOT MERGE - Automated checkov integration test [${PR_TYPE}] #${RUN_ID}" \
  --body "Please do not merge. This is an an automated intergration test from ${REPOSITORY}@${SHA}." \
  --base main \
  --head "$BRANCH" \
  --draft) # Added draft flag to avoid GitHub notifications for test PRs
echo "pr_url=$PR_URL" >> "$GITHUB_OUTPUT"
