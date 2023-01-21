# frozen_string_literal: true

require "test_helper"

class UuidNextV6Test < Minitest::Test
  def test_that_it_generates_a_proper_uuid_v6
    env_stubs do
      ::Uuid::Next::V6.reset_clock_seq!
      ::Uuid::Next::V6.reset_node_id!

      assert_equal "1b21dd21-3814-6000-8202-030405060708", ::Uuid::Next::V6.generate.to_s
    end
  end

  def test_clock_seq_is_mri_thread_safe
    result = (1..100).map do
      Thread.new { (1..10).map { ::Uuid::Next::V6.clock_seq_next } }
    end.map(&:value).flatten.uniq

    assert_equal 1000, result.length
  end
end

if ENV["BENCH"]
  class UuidNextV6Benchmark < Minitest::Benchmark
    def bench_v6_creation_speed
      assert_performance_constant do |n|
        n.times { ::Uuid::Next::V6.generate }
      end
    end
  end
end
