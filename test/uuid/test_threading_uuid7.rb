# frozen_string_literal: true

require "test_helper"

class TestThreadingUuid7 < Minitest::Test
  THREAD_COUNT = 20
  TOTAL_UUIDS = 5_000_000
  UUID_COUNT = TOTAL_UUIDS / THREAD_COUNT

  def setup
    @gen = Uuid::Version7.new
  end

  def generate_uuids
    Thread.new do
      (1..UUID_COUNT).map { @gen.generate.to_s }
    end
  end

  def skip_randomization_is_thread_safe
    # Insert a +sleep(0.001)+ call in between the pool empty check and write operations to thread switch. If this
    # isn't done, it is statistically unlikely to cause a thread-safety issue.
    Process.stub :clock_gettime, 0xcba987654321 do
      uuids = (1..THREAD_COUNT).map { generate_uuids }.map(&:join).map(&:value).flatten.uniq

      assert_equal TOTAL_UUIDS, uuids.length
    end
  end
end
