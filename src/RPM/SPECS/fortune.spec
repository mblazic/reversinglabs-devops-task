Name:           fortune
Version:        1.0.0
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

$ rpm -ql python3-fortune-1.0.0-1.amzn2023.noarch

In order to start the application as a service, the standard commands may be
used:

    systemctl enable --now fortune.service

This service is configured to start automatically in case of system reboot.


%package -n python3-%{name}-common
Summary:        %{summary}
BuildRequires:  python3-devel
%{?python_provide:%python_provide python3-%{name}-common}

%description -n python3-%{name}-common
Python3 packages of the fortune project

%package -n python3-%{name}
Summary:        %{summary}
BuildRequires:  python3-devel
Requires:       python3-flask
%{?python_provide:%python_provide python3-%{name}}

%description -n python3-%{name}
Python3 scripts and resources of the fortune project

%prep
%autosetup -n %{name}

%install
mkdir -p %{buildroot}%{_unitdir}
mkdir -p %{buildroot}/opt/%{name}

# Uncomment if Python venv is used
# Remove python3-flask as requires for package python3-%{name}
#%{python3} -m pip download -r requirements.txt -d %{buildroot}/opt/%{name}/lib
#%{python3} -m pip install --no-cache-dir --no-index -r requirements.txt --target=%{buildroot}%{python3_sitelib} --find-links=%{buildroot}/opt/%{name}/lib

cp -r %{_builddir}/%{name}/fortune.py source.py datafiles %{buildroot}/opt/%{name}/
cp %{_builddir}/%{name}/systemd/fortune.service %{buildroot}%{_unitdir}/

#%check
#PYTHONPATH=%{buildroot}/usr/lib/python3.9/site-packages/ %{python3} %{buildroot}/opt/fortune/unitest.py nosetests >/dev/null

%files -n python3-%{name}
/opt/%{name}/*
%{_unitdir}/fortune.service

# Uncomment if Python venv is used
# Remove python3-flask as requires for package python3-%{name}
#%{python3_sitelib}/*

%post -n python3-%{name}
systemctl daemon-reload

%postun -n python3-%{name}
systemctl daemon-reload

%changelog
%autochangelog
