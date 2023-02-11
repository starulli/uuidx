# frozen_string_literal: true

require "test_helper"

class TestThreadingUuid4 < Minitest::Test
  THREAD_COUNT = 20
  TOTAL_UUIDS = 5_000_000
  UUID_COUNT = TOTAL_UUIDS / THREAD_COUNT

  def setup
    @gen = Uuid::Version4.new
  end

  def generate_uuids
    Thread.new do
      (1..UUID_COUNT).map { @gen.generate }
    end
  end

  def test_randomization_is_thread_safe
    skip "do not run slow tests by default"

    Process.stub :clock_gettime, 0xcba987654321 do
      uuids = (1..THREAD_COUNT).map { generate_uuids }.map(&:join).map(&:value).flatten.uniq

      assert_equal TOTAL_UUIDS, uuids.length
    end
  end
end
