FROM ruby:2.7.0

RUN mkdir -p /payloader
WORKDIR /payloader

RUN apt-get update -qq && apt-get install -y ruby-dev nodejs postgresql-client

COPY Gemfile* /payloader/
RUN bundle install

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]