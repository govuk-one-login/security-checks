#!/usr/bin/env bash
set -euo pipefail

: "${PR_URL:?PR_URL is required}"

gh pr close "$PR_URL" \
  --repo "${TARGET_REPO}" \
  --delete-branch \
  --comment "Closed by automated integration test." || true
