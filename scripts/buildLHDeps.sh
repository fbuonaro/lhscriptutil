#!/bin/bash

MODULES_PATH="./modules"
for eachSubmodule in $(ls -1 ${MODULES_PATH})
do
    LHBUILD_SCRIPT="${MODULES_PATH}/${eachSubmodule}/scripts/lhbuild.sh"
    if [[ -f "${LHBUILD_SCRIPT}" ]];
    then
        ${LHBUILD_SCRIPT}
    fi
done
