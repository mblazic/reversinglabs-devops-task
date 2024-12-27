Name:           fortune
Version:        1.0.0
Release:        1%{?dist}
Summary:        A simple self-contained clone of fortune.

License:        unspecified
URL:            https://github.com/mblazic/reversinglabs-devops-task
Source0:        fortune-%{version}.tar.gz

Requires:       bash, systemd, python3, python3-pip
BuildRequires:  python3, python3-setuptools, python3-pip

%description

fortune v1.0.0
---------------------------------------------------------------------

Installation
---------------------------------------------------------------------
Explain installation steps here.

This solution is installed by a RPM package, that creates the following files:

    - /opt/fortune/ (application directory)
    - %{_unitdir}/fortune.service (service config file)

This files can be also listed with the following command:

$ rpm -ql foretune

In order to start the application as a service, the standard commands may be
used:

    systemctl enable --now fortune.service

This service is configured to start automatically in case of system reboot.

Logging
---------------------------------------------------------------------
Placeholder

%prep
%autosetup -n %{name}


%install
mkdir -p %{buildroot}/tmp/fortune
cp -r * %{buildroot}/tmp/fortune/

# Install python packages
pip3 install --no-cache-dir --no-index -r %{buildroot}/tmp/fortune/source/requirements.txt --prefix=%{buildroot}/usr --find-links=%{buildroot}/tmp/fortune/source/lib

# Install the systemd service file
mkdir -p %{buildroot}/%{_unitdir}
cp ~/rpmbuild/SOURCES/fortune.service %{buildroot}/%{_unitdir}/fortune.service


%files
%{_unitdir}/fortune.service
/tmp/fortune
#/usr/lib/python*/site-packages/*


%changelog
%autochangelog
