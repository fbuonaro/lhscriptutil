#!/bin/bash

VALID_STAGES="build-env|build|test-env|main|dist"

if [[ $# != 3 ]];
then
    echo "buildImage.sh <path to Dockerfile> <component name> <${VALID_STAGES}>"
    exit 1
fi

DOCKERFILE_PATH="$1"
COMPONENT="$2"
STAGE="$3"

if [[ ! ( "${STAGE}" == "build-env" ||
           "${STAGE}" == "build" ||
           "${STAGE}" == "test-env" ||
           "${STAGE}" == "main" ||
           "${STAGE}" == "dist" ) ]];
then
    echo "stage must be one of ${VALID_STAGES}, '${STAGE}' provided"
    exit 2
fi

TARGET_STAGE="${COMPONENT}-${STAGE}"
TARGET_TAG="${COMPONENT}:${STAGE}"

docker build --target "${TARGET_STAGE}" -t "${TARGET_TAG}" -f "${DOCKERFILE_PATH}" . || exit 3