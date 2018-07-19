FROM ruby:2.5

ADD . /app

WORKDIR /app

ENV RAILS_ENV development

RUN bundle install

EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
