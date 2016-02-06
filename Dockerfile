FROM vladshub/python-virtualenv
MAINTAINER Vladislav Shub <vlad6il@gmail.com>

RUN apk add --update libffi-dev && rm -rf /var/cache/apk/*

EXPOSE 8081

ENV SICKRAGE_VERSION 6.0.55

RUN wget -q "https://github.com/SiCKRAGETV/SiCKRAGE/archive/$SICKRAGE_VERSION.tar.gz" \
  && tar xzf *.tar.gz && rm *.tar.gz \
  && mv SiCKRAGE-* /sickrage 

RUN virtualenv /env

WORKDIR /sickrage

RUN . /env/bin/activate \
  && /env/bin/pip install git+https://github.com/sebastiaansamyn/python-fanart \
  && /env/bin/pip install --upgrade dogpile.cache \
  && /env/bin/pip install --upgrade configobj \
  && /env/bin/pip install --upgrade -r sickrage/requirements/requirements.txt \
  && /env/bin/pip install --upgrade -r sickrage/requirements/constraints.txt \
  && /env/bin/pip install --upgrade -r sickrage/requirements/ssl.txt 
#  && /env/bin/pip install --upgrade -r sickrage/requirements/optional.txt


CMD [". /env/bin/activate && /env/bin/python", "/sickrage/SickBeard.py", "--nolaunch", "--datadir=/data", "--config=/config/sickrage.ini"]
