#!/bin/sh

DIST_DIR="/lhdist"
REPO_NAME="lhdistrepo"
REPO_DIR="/${REPO_NAME}"

yum install -y createrepo yum-utils

mkdir -p "${REPO_DIR}"

cp -rf -u "${DIST_DIR}"/*.rpm "${REPO_DIR}"

rm -rf "${REPO_DIR}/repodata"
createrepo "${REPO_DIR}"

cat <<EOF > /etc/yum.repos.d/${REPO_NAME}.repo
[${REPO_NAME}]
name=LHDist Repository
baseurl=file://${REPO_DIR}
gpgcheck=0
enabled=1
EOF

yum -y clean all
