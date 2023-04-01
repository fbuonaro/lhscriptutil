#!/bin/bash

VALID_STAGES="build-env|build|test-env|main|dist"

if [[ $# < 3 ]];
then
    echo "buildImage.sh <path to Dockerfile> <component name> <${VALID_STAGES}>"
    exit 1
fi

DOCKERFILE_PATH="$1"
COMPONENT="$2"
STAGE="$3"

_BUILD_TAG="${LHBUILD_TAG}"
if [[ "x${_BUILD_TAG}" == "x" ]];
then
    _BUILD_TAG="local"
fi

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

GIT_COMMIT="$(git rev-parse HEAD)"
GIT_TAG="${COMPONENT}:${GIT_COMMIT}"

TARGET_TAG="${COMPONENT}:${STAGE}"

BUILD_TAG="${TARGET_TAG}-${_BUILD_TAG}"

docker build --build-arg GIT_COMMIT="${GIT_COMMIT}" --build-arg BUILD_TAG="${_BUILD_TAG}" --target "${TARGET_STAGE}" -t "${GIT_TAG}" -t "${TARGET_TAG}" -t "${BUILD_TAG}" -f "${DOCKERFILE_PATH}" . || exit 3