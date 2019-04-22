#!/usr/bin/env sh
set -e

msg() { echo -e "\e[32mINFO [$(date +%F_%H-%M-%S)] ---> $1\e[0m"; }
err() { echo -e "\e[31mERR [$(date +%F_%H-%M-%S)] ---> $1\e[0m" ; exit 1; }

[ -z "${CC_TEST_REPORTER_ID}" ] && err "Need to set Test Reporter ID (CC_TEST_REPORTER_ID)"
[ -z "${CC_COMMAND}" ] && err "Need to set Code Climate command to execute (CC_COMMAND)"

msg "Executing code climate test reporter with command '${CC_COMMAND}'"

export GIT_BRANCH="${CF_BRANCH}"
export GIT_COMMIT_SHA="${CF_REVISION}"
export GIT_COMMITTED_AT="$(git log -1 --pretty=%ct)"
export CI_NAME="${CF_REPO_NAME}"
export CI_BUILD_ID="${CF_BUILD_ID}"
export CI_BUILD_URL="${CF_BUILD_URL}"

cc-test-reporter ${CC_COMMAND}