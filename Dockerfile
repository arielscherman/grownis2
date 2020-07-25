FROM ruby:2.7.1-alpine

ENV BUNDLER_VERSION=2.1.4

RUN apk add --update --no-cache \
      binutils-gold \
      build-base \
      curl \
      file \
      g++ \
      gcc \
      git \
      less \
      libstdc++ \
      libffi-dev \
      libc-dev \ 
      linux-headers \
      libxml2-dev \
      libxslt-dev \
      libgcrypt-dev \
      make \
      netcat-openbsd \
      nodejs \
      openssl \
      pkgconfig \
      postgresql-dev \
      py-pip \
      tzdata \
      yarn 

RUN gem install bundler -v 2.1.4

WORKDIR /app

# Gems
COPY Gemfile Gemfile.lock ./
RUN bundle config build.nokogiri --use-system-libraries
RUN bundle check || bundle install

# Javascript assets
COPY package.json yarn.lock ./
RUN yarn install --check-files

# Copies all the things into the workdir
COPY . ./

# Using an entrypoint script allows us to run the container as an executable
ENTRYPOINT ["./entrypoints/docker-entrypoint.sh"]
