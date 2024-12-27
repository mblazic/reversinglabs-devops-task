%{!?_version: %define _version 1.0.0 }
%global srcname fortune

Name:           python-%{srcname}
Version:        %{_version}
Release:        1%{?dist}
Summary:        A simple self-contained clone of fortune.
License:        LGPLv3+
Source0:        %{pypi_source}
URL:            https://github.com/mblazic/reversinglabs-devops-task

BuildArch:       noarch
BuildRequires:   python3-devel python3-setuptools
Requires:        python3

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


%package -n python3-%{srcname}-common
Summary:        %{summary}
BuildRequires:  python3-devel
%{?python_provide:%python_provide python3-%{srcname}-common}

%description -n python3-%{srcname}-common
Python3 packages of the fortune project

%package -n python3-%{srcname}
Summary:        %{summary}
BuildRequires:  python3-devel
Requires:       python3-%{srcname}-common
%{?python_provide:%python_provide python3-%{srcname}}

%description -n python3-%{srcname}
Python3 scripts and resources of the fortune project

%prep
%autosetup -n %{srcname}-%{_version}

%build
%{__python3} setup.py bdist_wheel

%install
mkdir -p %{buildroot}/usr/bin
mkdir -p %{buildroot}/%{_sysconfdir}/systemd/system
cd "%{_builddir}/%{srcname}-%{_version}/dist"

%{__python3} -m pip download -r requirements.txt -d fortune/usr/
%{__python3} -m pip install --no-cache-dir --no-index -r requirements.txt --target=%{buildrooot}%{python3_sitelib} --find-links=%{buildroot}/tmp/fortune/source/lib


cp %{_builddir}/%{srcname}-%{_version}/bin/logging.conf %{buildroot}/%{_sysconfdir}/fooapp/logging.conf
cp %{_builddir}/%{srcname}-%{_version}/share/doc/fooapp/rsyslog/fooapp.conf %{buildroot}/%{_sysconfdir}/rsyslog.d/fooapp.conf
cp %{_builddir}/%{srcname}-%{_version}/bin/fooapp.py %{buildroot}/usr/bin/fooapp.py


%check
cd "%{_builddir}/%{srcname}-%{_version}"
%{__python3} setup.py nosetests >/dev/null

# Install the systemd service file
mkdir -p %{buildroot}/%{_unitdir}
cp ~/rpmbuild/SOURCES/fortune.service %{buildroot}/%{_unitdir}/fortune.service


%files
%{_unitdir}/fortune.service
/tmp/fortune
#/usr/lib/python*/site-packages/*


%post -n python3-%{srcname}
systemctl daemon-reload

%changelog
%autochangelog
