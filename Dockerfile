FROM ruby:2.5.3-slim

RUN set -e \
    && apt-get update -y \
    && apt-get install -y build-essential

RUN mkdir -p /opt/app

COPY . /opt/app

WORKDIR /opt/app
RUN set -e \
    && mkdir -p /opt/app/tmp/pids \
    && gem update --system && gem install bundler --no-document && bundle

ENV REDIS_URL=redis://0.0.0.0:6379/

ENTRYPOINT [ "bundle", "e", "unicorn" ]
CMD [ "-c", "./unicorn.rb" ]