#!/bin/bash

MODULES_DIR="./modules"
TOPLEVEL_DIR=${PWD}
for SUBMODULE in $(ls -1 ${MODULES_DIR})
do
    SUBMODULE_DIR="${MODULES_DIR}/${SUBMODULE}"
    LHBUILD_SCRIPT="./scripts/lhbuild.sh"
    cd ${SUBMODULE_DIR}
    if [[ -f "${LHBUILD_SCRIPT}" ]];
    then
        ${LHBUILD_SCRIPT}
    fi
    cd ${TOPLEVEL_DIR}
done
