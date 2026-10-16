#!/usr/bin/env bash
set -euo pipefail

cd devplatform-demo-sam-app

git config user.name "github-actions[bot]"
git config user.email "41898282+github-actions[bot]@users.noreply.github.com"

BRANCH="checkov-integration-test-${RUN_ID}"
git checkout -b "$BRANCH"

echo "# integration-test-${RUN_ID}" >> sam-app/template.yaml

git add sam-app/template.yaml
git commit -m "test: trigger checkov scan for integration test run ${RUN_ID}"
git push origin "$BRANCH"
echo "branch=$BRANCH" >> "$GITHUB_OUTPUT"
