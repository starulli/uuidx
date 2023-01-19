ARG RUBY_VERSION

FROM ruby:$RUBY_VERSION

WORKDIR /proj

COPY uuid-next.gemspec Gemfile Gemfile.lock ./
RUN mkdir -p lib/uuid/next
COPY lib/uuid/next/version.rb lib/uuid/next/

RUN gem install bundler:2.4.3 && bundle install
CMD ["rake"]
