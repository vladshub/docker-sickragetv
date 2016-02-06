FROM vladshub/docker-python-virtualenv
MAINTAINER Vladislav Shub <vlad6il@gmail.com>

EXPOSE 8081

ONBUILD RUN virtualenv /env && /env/bin/pip install --upgrade pip \
  && /env/bin/pip install git+https://github.com/sebastiaansamyn/python-fanart \
  && /env/bin/pip install --upgrade dogpile.cache \
  && /env/bin/pip install --upgrade configobj

ENV SICKRAGE_VERSION 6.0.55

ONBUILD RUN curl -s -L "https://github.com/SiCKRAGETV/SiCKRAGE/archive/$SICKRAGE_VERSION.tar.gz" | tar xz && \
 mv SiCKRAGE-$SICKRAGE_VERSION /sickrage

WORKDIR /sickrage

ONBUILD RUN /env/bin/pip install --upgrade -r sickrage/requirements/requirements.txt \
  && /env/bin/pip install --upgrade -r sickrage/requirements/constraints.txt \
  && /env/bin/pip install --upgrade -r sickrage/requirements/ssl.txt \
  && /env/bin/pip install --upgrade -r sickrage/requirements/optional.txt

CMD ["/env/bin/python", "/sickrage/SickBeard.py", "--nolaunch", "--datadir=/data", "--config=/config/sickrage.ini"]
