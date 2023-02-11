ARG RUBY_VERSION

FROM ruby:$RUBY_VERSION

WORKDIR /proj

COPY uuidx.gemspec Gemfile Gemfile.lock ./
RUN mkdir -p lib/uuid
COPY lib/uuid/gem_version.rb lib/uuid/

RUN gem install bundler:2.4.3 && bundle install
CMD ["rake", "test"]
