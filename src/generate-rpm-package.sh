#!/bin/bash

set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail  # don't hide errors within pipes

# Set the version of the application, used for tar directory naming
VERSION=1.0.0

# Remove directories used in the previous run, before going further
rm -rf ~/rpmbuild
rm -rf /tmp/fortune/

# Install RPM packages required for the RPM package build process
sudo dnf install -y rpm-build rpmdevtools

# Create ~/rpmbuild directory
rpmdev-setuptree

# Change work directory to the script location
cd "$(dirname "$0")"

# Temporary copy pip requirements.txt to the application directory
# Copy RPM spec to rpmbuild directory
cp requirements.txt fortune/
cp RPM/SPECS/fortune.spec  ~/rpmbuild/SPECS/

# Copy complete and ready application directory to /tmp
cp -r fortune /tmp

# Create .tar.gz archive in /tmp
tar --exclude='__pycache__' -czf fortune-$VERSION.tar.gz -C /tmp/ fortune
# Remove temporary copy of pip requirements.txt from the application directory
rm fortune/requirements.txt

# Move tar.gz archive to ~/rpmbuild/SOURCES/
mv fortune-$VERSION.tar.gz ~/rpmbuild/SOURCES/

# Build application RPM package
rpmbuild -v -bb ~/rpmbuild/SPECS/fortune.spec

# Remove directories used in the current run, before going further
rm -rf /tmp/fortune

# Copy application RPM package to /tmp, ready to copy/deploy to other nodes
cp ~/rpmbuild/RPMS/noarch/* /tmp


exit 0
