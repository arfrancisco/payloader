FROM ruby:2.7.0

RUN apt-get update -qq && apt-get install -y ruby-dev nodejs postgresql-client

WORKDIR /payloader
COPY Gemfile* /payloader/
RUN bundle install

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]