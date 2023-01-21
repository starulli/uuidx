# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "uuid/next"

require "minitest"

class Minitest::Test
  def env_stubs(&block)
    Process.stub :clock_gettime, 0 do
      SecureRandom.stub :bytes, "\x1\x2\x3\x4\x5\x6\x7\x8" do
        block.call
      end
    end
  end
end

require "minitest/benchmark" if ENV["BENCH"]
require "minitest/autorun"
