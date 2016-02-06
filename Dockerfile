FROM python:2.7.10
MAINTAINER Vladislav Shub <vlad6il@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV PYTHONIOENCODING utf-8
EXPOSE 8081

RUN pip install --upgrade pip && \
 pip install git+https://github.com/sebastiaansamyn/python-fanart && \
 pip install --upgrade dogpile.cache && \
 pip install --upgrade configobj

ENV SICKRAGE_VERSION 6.0.55

RUN curl -s -L "https://github.com/SiCKRAGETV/SickRage/archive/$SICKRAGE_VERSION.tar.gz" | tar xz && \
 mv SickRage-$SICKRAGE_VERSION /sickrage

WORKDIR /sickrage

RUN pip install --upgrade -r requirements/global.txt && \
  pip install --upgrade -r requirements/ssl.txt && \
  pip install --upgrade -r requirements/optional.txt

CMD ["python", "/sickrage/SickBeard.py", "--nolaunch", "--install-optional", "--datadir=/data", "--config=/config/sickrage.ini", "--user"]
