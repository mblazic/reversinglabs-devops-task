FROM --platform=$BUILDPLATFORM python:3.13-alpine

LABEL MAINTAINER="Marko Blazic" \
      VERSION="1.0" 

WORKDIR /opt/fortune

COPY requirements.txt fortune.py source.py /opt/fortune/
COPY datafiles /opt/fortune/datafiles

RUN pip3 install --upgrade pip && pip install --no-cache-dir -r requirements.txt

EXPOSE 5000

ENTRYPOINT [ "python3" ]

CMD [ "fortune.py" ]
