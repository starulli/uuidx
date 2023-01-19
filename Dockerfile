ARG RUBY_VERSION

FROM ruby:$RUBY_VERSION

WORKDIR /proj

COPY uuid-next.gemspec Gemfile Gemfile.lock ./
RUN mkdir -p lib/uuid/next
COPY lib/uuid/next/version.rb lib/uuid/next/

RUN bundle install
CMD ["rake"]
