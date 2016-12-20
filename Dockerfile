FROM ruby:2.3.1

RUN apt-get update -qq && apt-get install -y build-essential

# for postgres
RUN apt-get install -y libpq-dev

ENV APP_HOME /srv/http/timesheet
ENV RAILS_ENV development
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

CMD bundle exec passenger start -p 8000

ADD Gemfile* $APP_HOME/
RUN bundle install

ADD . $APP_HOME/

COPY docker/database.yml $APP_HOME/config/database.yml

#RUN rake db:setup
