FROM ruby:3.1-alpine

ENV ROOT="/app"
ENV LANG=C.UTF-8
ENV TZ=Asia/Tokyo

WORKDIR ${ROOT}

RUN apk update && \
    apk upgrade && \
    apk add --no-cache \
      gcc \
      g++ \
      git \
      wget \
      libc-dev \
      libxml2-dev \
      linux-headers \
      make \
      tzdata \
      bash \
      less \
      curl \
      postgresql-client \
      libpq-dev && \
    apk add --virtual build-packs --no-cache \
      build-base \
      curl-dev


# Mac環境下でnokogiriがLoadErrorにならないよう対策
RUN apk add --no-cache gcompat

# Node.jsとYarnのインストール
RUN apk add --no-cache nodejs yarn

# imagemagickのインストール
RUN apk add --no-cache imagemagick

# graphvizのインストール
RUN apk add --no-cache graphviz

# bundlerとGemのインストール
RUN gem install bundler
RUN gem install rails -v "7.0.2"

ADD Gemfile .
ADD Gemfile.lock .

RUN bundle install -j4 && \
    apk del build-packs

ADD . ${ROOT}