# frozen_string_literal: true

require "test_helper"

class TestUuidVersion6 < Minitest::Test
  TIME = 0xcba987654321

  def clock_seq(uuid)
    (uuid.value >> 48) & 0x3fff
  end

  def setup
    Process.stub :clock_gettime, TIME do
      SecureRandom.stub :bytes, "\x0\x1\x2\x3\x4\x5\x6\x7\x8\x9\xa\xb" do
        @gen = Uuid::Version6.new
        @gen.reset!
        @uuid = @gen.generate
      end
    end
  end

  def test_clock_sequence_changes_when_time_drifts_backward
    past_uuid = Process.stub :clock_gettime, TIME - 100 do
      @gen.generate
    end

    refute_equal clock_seq(past_uuid), clock_seq(@uuid)
  end

  def test_clock_sequence_changes_when_two_uuids_have_the_same_timestamp
    past_uuid = Process.stub :clock_gettime, TIME do
      @gen.generate
    end

    refute_equal clock_seq(past_uuid), clock_seq(@uuid)
  end

  def test_uuid_is_correct
    assert_equal "1b21fdb7-3942-6ec0-8203-020304050607", @uuid.to_s
  end

  def test_version_is_correct
    assert_equal 6, @uuid.version
  end

  def test_variant_is_correct
    assert_equal 2, @uuid.variant
  end

  def test_clock_sequence_is_correct
    assert_equal 515, clock_seq(@uuid)
  end
end
