#!/bin/sh

DIST_DIR="/lhdist"
REPO_DIR="/lhdistrepo"

yum install -y createrepo yum-utils

mkdir -p "${REPO_DIR}"

cp -rf "${DIST_DIR}/*.rpm" "${REPO_DIR}"

createrepo "${REPO_DIR}"

cat <<EOF > /etc/yum.repos.d/lhdistrepo.repo
[lhdistrepo]
name=LHDist Repository
baseurl=file://${REPO_DIR}
gpgcheck=0
enabled=1
EOF

yum -y clean all
yum -y update