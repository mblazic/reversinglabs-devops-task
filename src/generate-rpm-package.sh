#!/bin/bash

set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail  # don't hide errors within pipes

VERSION=1.0.0

rm -rf ~/rpmbuild
rm -rf /tmp/fortune/

sudo dnf install -y rpm-build rpmdevtools

rpmdev-setuptree

cd "$(dirname "$0")"

cp requirements.txt fortune/
cp RPM/SPECS/fortune.spec  ~/rpmbuild/SPECS/

cp -r fortune /tmp

tar --exclude='__pycache__' -czf fortune-$VERSION.tar.gz -C /tmp/ fortune
rm fortune/requirements.txt

mv fortune-$VERSION.tar.gz ~/rpmbuild/SOURCES/

rpmbuild -v -bb ~/rpmbuild/SPECS/fortune.spec

rm -rf /tmp/fortune
cp ~/rpmbuild/RPMS/noarch/* /tmp


exit 0
