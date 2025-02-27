#!/bin/bash

set -eou pipefail

version=${1:?"pass the version as the parameter, e.g \"0.5.0\""}
mkdir "${RH_COMMUNITY_REPO_PATH}/community-operators/mongodb-atlas-kubernetes/${version}"
cp -r bundle.Dockerfile bundle/manifests bundle/metadata "${RH_COMMUNITY_REPO_PATH}/community-operators/mongodb-atlas-kubernetes/${version}"
cd "${RH_COMMUNITY_REPO_PATH}/community-operators/mongodb-atlas-kubernetes/"

# replace the move instructions in the docker file
sed -i 's/COPY bundle\/manifests/COPY manifests/' "${version}/bundle.Dockerfile"
sed -i 's/COPY bundle\/metadata/COPY metadata/' "${version}/bundle.Dockerfile"
sed -i 's/COPY bundle\/tests\/scorecard/COPY tests\/scorecard/' "${version}/bundle.Dockerfile"

# commit
git checkout -b "mongodb-atlas-operator-community-${version}"
git add "${version}"
git commit -m "MongoDB Atlas Operator ${version}" --signoff "${version}"
git push origin mongodb-atlas-operator-community-"${version}"
