FROM sitespeedio/webbrowsers:firefox-49.0-chrome-54.0

COPY start.sh /start.sh

RUN apt-get update

RUN apt-get install -y git

# Install NodeJS
RUN apt-get install curl python-software-properties
RUN curl -sL https://deb.nodesource.com/setup_11.x | sudo -E bash -
RUN apt-get install nodejs

# Add user and install sitespeed.io
RUN useradd --user-group --create-home --shell /bin/false app
ENV HOME=/home/app
RUN git clone https://github.com/sitespeedio/sitespeed.io.git $HOME/sitespeed.io
RUN chown -R app:app $HOME/*
USER app
WORKDIR $HOME/sitespeed.io
RUN npm install --production

ENTRYPOINT ["/start.sh"]
VOLUME /sitespeed.io
WORKDIR /sitespeed.io