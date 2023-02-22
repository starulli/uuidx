# frozen_string_literal: true

require "test_helper"

class TestUuidVersion6 < Minitest::Test
  TIME = 0x0102030405060708

  def setup
    Process.stub :clock_gettime, TIME do
      SecureRandom.stub :bytes, "\x0\x2\x4\x6\x8\xa\x9\x9" do
        @gen = Uuidx::Version6.new
        @uuid = @gen.generate
      end
    end
  end

  def test_clock_sequence_changes_when_time_drifts_backward
    past_uuid = Process.stub :clock_gettime, TIME - 100 do
      @gen.generate
    end

    refute_equal past_uuid, @uuid
  end

  def test_clock_sequence_changes_when_two_uuids_have_the_same_timestamp
    past_uuid = Process.stub :clock_gettime, TIME do
      @gen.generate
    end

    refute_equal past_uuid, @uuid
  end

  def test_uuid_is_correct
    assert_equal "1b4b254a-d27b-65d4-8201-0b0806040200", @uuid
  end

  def test_version_is_correct
    assert_equal "6", @uuid[14]
  end

  def test_variant_is_correct
    assert_equal "8", @uuid[19]
  end

  def test_clock_sequence_is_correct
    assert_equal "8201", @uuid[19..22]
  end

  def test_node_id_multicast_bit_is_set
    assert_equal "0b", @uuid[24..25]
  end
end
