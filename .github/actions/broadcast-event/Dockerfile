FROM ruby:2.7.2-alpine

RUN gem install bundler
RUN gem install octokit

COPY entrypoint.sh /entrypoint.sh
COPY action.rb /action.rb

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
