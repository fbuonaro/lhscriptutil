#!/bin/bash

# where software is unpacked and built
mkdir -p $1/BUILD
# where new binary package files are written
mkdir -p $1/RPMS
# original sources
mkdir -p $1/SOURCES
# spec files for each package to be built
mkdir -p $1/SPECS
# where new source package files are written
mkdir -p $1/SRPMS
