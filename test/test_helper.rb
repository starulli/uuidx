# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "uuid/next"
require "uuid"

require "minitest"
require "minitest/benchmark" if ENV["BENCH"]
require "minitest/autorun"

class Minitest::Test
  def env_stubs(time: 0, bytes: "\x1\x2\x3\x4\x5\x6\x7\x8", &block)
    Process.stub :clock_gettime, time do
      SecureRandom.stub :bytes, bytes do
        block.call
      end
    end
  end
end