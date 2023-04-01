##################################################################################
# STAGE 0 - base environment with first set of runtime dependencies
##################################################################################
ARG BUILD_TAG
ARG GIT_COMMIT

FROM centos:centos7 as lhscriptutil-base-env

RUN yum -y --enablerepo=extras install epel-release && \
    yum -y install https://repo.ius.io/ius-release-el7.rpm && \
    yum -y install http://repo.okay.com.mx/centos/7/x86_64/release/okay-release-1-5.el7.noarch.rpm && \
    yum clean all

##################################################################################
# STAGE 1 - build tools and libraries needed to build lhscriptutil
##################################################################################
FROM lhscriptutil-base-env as lhscriptutil-build-env

ADD ./scripts /lhscriptutil/scripts
RUN /lhscriptutil/scripts/refreshOrSetupLHDistYumRepo.sh

##################################################################################
# STAGE 2 - the lhscriptutil source and compiled binaries
##################################################################################
FROM lhscriptutil-build-env as lhscriptutil-build

# TODO - remove when things are properly packaged
ADD ./cmake /lhscriptutil/cmake
RUN mkdir -p /lhdist && touch /lhdist/.keepdir

ENV BUILD_TAG=${BUILD_TAG}
LABEL build_tag="${BUILD_TAG}"
ENV GIT_COMMIT=${GIT_COMMIT}
LABEL git_commit="${GIT_COMMIT}"

##################################################################################
# STAGE 3 - the image with all built build/runtime dependencies, lhscriptutil 
#           binaries and test binaries needed for running integration tests
##################################################################################
FROM lhscriptutil-build as lhscriptutil-test-env

##################################################################################
# STAGE 4 - the base image with additional built runtime dependencies and 
#           lhscriptutil binaries includes nothing from build-env
##################################################################################
FROM lhscriptutil-base-env as lhscriptutil-main

##################################################################################
# STAGE 5 - the base image with /lhdist populated with custom packages required to
#           build lhscriptutil
##################################################################################
FROM lhscriptutil-base-env as lhscriptutil-dist

COPY --from=lhscriptutil-build /lhdist/ /lhdist/
# TODO - remove when things are properly packaged
COPY --from=lhscriptutil-build /lhscriptutil/ /lhscriptutil/