# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "uuid/next"

require "minitest/benchmark" if ENV["BENCH"]
require "minitest/autorun"
