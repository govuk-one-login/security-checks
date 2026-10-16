#!/usr/bin/env bash
set -euo pipefail

: "${BRANCH:?BRANCH is required}"

until WORKFLOW_RUN_ID=$(gh run list \
  --repo "${TARGET_REPO}" \
  --branch "$BRANCH" \
  --workflow "pre-merge-checks.yaml" \
  --json databaseId \
  --jq '.[0].databaseId') && [ -n "$WORKFLOW_RUN_ID" ]; do
  sleep 5
done

gh run watch "$WORKFLOW_RUN_ID" \
  --repo "${TARGET_REPO}" || true

CONCLUSION=$(gh run view "$WORKFLOW_RUN_ID" \
  --repo "${TARGET_REPO}" \
  --json conclusion \
  --jq '.conclusion')

if [ "$CONCLUSION" != "failure" ]; then
  echo "Expected checkov to fail but got: $CONCLUSION"
  exit 1
fi
