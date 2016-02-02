FROM python:2.7.10
MAINTAINER Vladislav Shub <vlad6il@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV PYTHONIOENCODING utf-8
EXPOSE 8081

RUN pip install --upgrade pip && \
 pip install git+https://github.com/sebastiaansamyn/python-fanart && \
 pip install --upgrade dogpile.cache && \
 pip install --upgrade configobj

ENV SICKRAGE_VERSION 6.0.30

RUN curl -s -L "https://github.com/SiCKRAGETV/SickRage/archive/$SICKRAGE_VERSION.tar.gz" | tar xz && \
 mv SickRage-$SICKRAGE_VERSION /sickrage

WORKDIR /sickrage

RUN python /sickrage/SickBeard.py --nolaunch --install-optional --datadir=/data --config=/config/sickrage.ini --user -d || echo 0

CMD ["python", "/sickrage/SickBeard.py", "--nolaunch", "--install-optional", "--datadir=/data", "--config=/config/sickrage.ini", "--user"]
