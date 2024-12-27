#!/bin/bash

set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail  # don't hide errors within pipes

# preparation
sudo rm -rf ~/rpmbuild
rm -rf /tmp/fortune/

sudo dnf install -y rpm-build rpmdevtools

rpmdev-setuptree

cd "$(dirname "$0")"
mkdir -p RPM/SPECS



# cp -ra scripts/fortune.spec ~/rpmbuild/SPECS/
# cp -ra scripts/fortune.service ~/rpmbuild/SOURCES/

# # execution
# pip3 download -r source/requirements.txt -d source/lib/

# mkdir /tmp/fortune
# cp -ra source/ /tmp/fortune

# tar --exclude='__pycache__' -czf fortune-$VERSION.tar.gz -C /tmp/ fortune
# mv fortune-$VERSION.tar.gz ~/rpmbuild/SOURCES/

# rpmbuild -v -bb ~/rpmbuild/SPECS/fortune.spec

# rm -rf /tmp/fortune

# cp ~/rpmbuild/RPMS/x86_64/* .


# exit 0
