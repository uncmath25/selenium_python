FROM python:3.7-slim
LABEL maintainer="Colton Willig <coltonwillig@gmail.com>"

RUN apt-get update \
    && apt-get install -yqq \
        bzip2 \
        libdbus-glib-1-2 \
        libgtk-3-dev \
        libxt-dev \
        wget \
    && rm -rf /var/lib/apt/lists/*

ENV USER uncmath25
RUN useradd -ms /bin/bash $USER
USER $USER
WORKDIR /home/$USER

RUN wget https://github.com/mozilla/geckodriver/releases/download/v0.25.0/geckodriver-v0.25.0-linux64.tar.gz -O geckodriver.tar.gz \
    && tar -xzvf geckodriver.tar.gz \
    && rm geckodriver.tar.gz

RUN wget https://download-installer.cdn.mozilla.net/pub/firefox/releases/69.0.1/linux-x86_64/en-US/firefox-69.0.1.tar.bz2 -O firefox.tar.bz2 \
    && tar -xjvf firefox.tar.bz2 \
    && rm firefox.tar.bz2

USER root
RUN pip3 install --upgrade pip==19.2.3
COPY requirements.txt requirements.txt
RUN pip3 install --no-cache-dir -r requirements.txt \
    && rm requirements.txt

COPY entrypoint.sh entrypoint.sh
RUN chmod +x entrypoint.sh

USER $USER
ENTRYPOINT ./entrypoint.sh
