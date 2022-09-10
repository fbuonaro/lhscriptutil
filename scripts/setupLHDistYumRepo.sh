#!/bin/sh

yum install -y createrepo yum-utils

mkdir /lhdist

createrepo /lhdist

cat <<EOF > /etc/yum.repos.d/lhdist.repo
[lhdist]
name=LHDist Repository
baseurl=file:///lhdist
gpgcheck=0
enabled=1
EOF

yum clean all
yum update