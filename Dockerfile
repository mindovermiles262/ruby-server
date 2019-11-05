FROM ruby:2.6-alpine
MAINTAINER Andy Duss <mindovermiles262@gmail.com>

RUN apk add --update alpine-sdk sqlite-dev mariadb-dev

COPY Gemfile /standard_note/Gemfile
COPY Gemfile.lock /standard_note/Gemfile.lock
WORKDIR /standard_note
RUN gem install bundler && bundle install

COPY . /standard_note
RUN rails db:migrate

CMD ["rails", "server", "-b", "0.0.0.0"]
