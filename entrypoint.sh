#!/bin/bash
set -xeu

pull_request_id=$(cat "$GITHUB_EVENT_PATH" | jq 'if (.issue.number != null) then .issue.number else .number end')

if [ $pull_request_id == "null" ]; then
  echo "Could not find a pull request ID. Is this a pull request?"
  exit 0
fi

eval python3 /action/run_action.py \
  --clang-tidy-fixes $INPUT_CLANG_TIDY_FIXES \
  --pull-request-id $pull_request_id \
  --repository-root $PWD
