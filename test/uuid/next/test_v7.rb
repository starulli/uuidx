# frozen_string_literal: true

require "test_helper"

class UuidNextV7Test < Minitest::Test
  def test_that_it_generates_a_proper_uuid_v7
    env_stubs time: 1234567898765, bytes: "\x1\x2\x3\x4\x5\x6\x7\x8" * 80 do
      ::Uuid::Next::V7.refill_pool!

      assert_equal "011f71fb-268d-7708-8102-030405060708", ::Uuid::Next::V7.generate.to_s
    end
  end
end

if ENV["BENCH"]
  class UuidNextV7Benchmark < Minitest::Benchmark
    def bench_v7_creation_speed
      assert_performance_constant do |n|
        n.times { ::Uuid::Next::V7.generate }
      end
    end
  end
end
