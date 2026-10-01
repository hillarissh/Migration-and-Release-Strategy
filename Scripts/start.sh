#!/bin/bash
set -e

ORG="OrgName"
REPO="RepoName"

#To generate authorization token valid for 1 hr
RUNNER_TOKEN=$(curl -s -L -X POST \
  -H "Authorization: Bearer $GITHUB_PAT" \
  -H "Accept: application/vnd.github+json" \
  https://api.github.com/repos/${ORG}/${REPO}/actions/runners/registration-token \
  | jq -r .token)
cd /home/docker/actions-runner

./config.sh --unattended \
  --url https://github.com/${ORG}/${REPO} \
  --token ${RUNNER_TOKEN} \
  --name $(hostname) \
  --work _work \
  --replace

exec ./run.sh
