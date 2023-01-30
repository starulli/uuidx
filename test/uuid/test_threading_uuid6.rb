# frozen_string_literal: true

require "test_helper"

class TestThreadingUuid6 < Minitest::Test
  THREAD_COUNT = 20
  TOTAL_UUIDS = 5_000_000
  UUID_COUNT = TOTAL_UUIDS / THREAD_COUNT

  def generate_uuids
    Thread.new do
      (1..UUID_COUNT).map { Uuid::Version6.generate.to_s }
    end
  end

  def test_clock_sequence_is_thread_safe
    uuids = (1..THREAD_COUNT).map { generate_uuids }.map(&:join).map(&:value).flatten.uniq

    assert_equal TOTAL_UUIDS, uuids.length
  end
end
