# frozen_string_literal: true

require "bundler/gem_tasks"
require "rake/testtask"
require "rdoc/task"
require "rubocop/rake_task"
require_relative "lib/uuid/gem_version"


Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/test_*.rb"]
end

RuboCop::RakeTask.new

RDoc::Task.new do |r|
  r.main = "README.md"
  r.rdoc_dir = "docs"
  r.rdoc_files = Dir["README.md", "LICENSE.txt", "CHANGELOG.md", "lib/**/*.rb"]
  r.title = "uuidx #{Uuid::VERSION} documentation"
end

task default: %i[test rubocop]
