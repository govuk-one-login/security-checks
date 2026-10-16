#!/usr/bin/env bash
set -euo pipefail

cd devplatform-demo-sam-app

git config user.name "github-actions[bot]"
git config user.email "41898282+github-actions[bot]@users.noreply.github.com"

BRANCH="checkov-integration-test-fail-${RUN_ID}"
git checkout -b "$BRANCH"

sed -i '/^Outputs:/i\  FailingTestRole:\
    Type: AWS::IAM::Role\
    Properties:\
      AssumeRolePolicyDocument:\
        Version: "2012-10-17"\
        Statement:\
          - Effect: Allow\
            Principal:\
              Service: lambda.amazonaws.com\
            Action: sts:AssumeRole\
' sam-app/template.yaml

git add sam-app/template.yaml
git commit -m "test: trigger checkov failure for integration test run ${RUN_ID}"
git push origin "$BRANCH"
echo "branch=$BRANCH" >> "$GITHUB_OUTPUT"
