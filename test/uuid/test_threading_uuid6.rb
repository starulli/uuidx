# frozen_string_literal: true

require "test_helper"

class TestThreadingUuid6 < Minitest::Test
  THREAD_COUNT = 3
  TOTAL_UUIDS = 15_000
  UUID_COUNT = TOTAL_UUIDS / 3

  def generate_uuids
    Thread.new do
      (1..UUID_COUNT).map { Uuid::Version6.generate.to_s }
    end
  end

  def test_clock_sequence_is_thread_safe
    # Insert a +sleep(0.001)+ call in between the clock sequence increment and read operations to thread switch. If this
    # isn't done, it is statistically unlikely to cause a thread-safety issue.
    Process.stub :clock_gettime, 0xcba987654321 do
      SecureRandom.stub :bytes, "\x0\x0\x0\x0\x1\x2\x3\x4" do
        Uuid::Version6.send(:reset_node_id!)
        Uuid::Version6.send(:reset_clock_sequence!)

        uuids = (1..THREAD_COUNT).map { generate_uuids }.map(&:join).map(&:value).flatten.uniq

        assert_equal TOTAL_UUIDS, uuids.length
      end
    end
  end
end
