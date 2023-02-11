# frozen_string_literal: true

require_relative "lib/uuid/gem_version"

Gem::Specification.new do |spec|
  spec.name = "uuidx"
  spec.version = Uuid::VERSION
  spec.authors = ["Stephan Tarulli"]
  spec.email = ["srt@tinychameleon.com"]

  spec.summary = "A fast Ruby implementation of UUID versions 4, 6, 7, and 8 🪪"
  spec.description = "A fast Ruby implementation of UUID versions 4, 6, 7, and 8 🪪"
  spec.homepage = "https://github.com/tinychameleon/uuidx"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.7.0"

  spec.metadata["rubygems_mfa_required"] = "true"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = File.join(spec.homepage, "blob/main/CHANGELOG.md")
  spec.metadata["bug_tracker_uri"] = File.join(spec.homepage, "issues")
  spec.metadata["documentation_uri"] = "https://tinychameleon.github.io/uuidx/"

  spec.files = Dir["README.md", "CHANGELOG.md", "LICENSE.txt", "lib/**/*.rb"]
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
