# frozen_string_literal: true

require "test_helper"

class UuidNextV8Test < Minitest::Test
  class OverflowingUuid < ::Uuid::Next::V8
    class << self
      def custom_a
        2**49
      end

      def custom_b
        2**13
      end

      def custom_c
        2**63
      end
    end
  end

  def test_that_it_generates_a_proper_uuid_v8
    assert_equal "00000000-0000-8000-8000-000000000000", OverflowingUuid.generate.to_s
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
