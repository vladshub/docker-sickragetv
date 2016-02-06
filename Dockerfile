FROM vladshub/python-virtualenv
MAINTAINER Vladislav Shub <vlad6il@gmail.com>

ENV SICKRAGE_VERSION 6.0.55
EXPOSE 8081

RUN wget -q "https://github.com/SiCKRAGETV/SiCKRAGE/archive/$SICKRAGE_VERSION.tar.gz" \
  && tar xzvf *.tar.gz && rm *.tar.gz \
  && mv SiCKRAGE-* /sickrage 

RUN virtualenv /env

WORKDIR /sickrage

CMD ["/env/bin/python", "/sickrage/SickBeard.py", "--nolaunch", "--datadir=/data", "--config=/config/sickrage.ini"]
