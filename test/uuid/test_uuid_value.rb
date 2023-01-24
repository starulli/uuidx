# frozen_string_literal: true

require "test_helper"

class TestUuidValue < Minitest::Test
  VALUE_AS_HEX = "011f71fb-268d-7708-8102-030405060708"
  VALUE_AS_INT = 0x011f71fb268d77088102030405060708

  def setup
    @uuid = ::Uuid::Value.from(VALUE_AS_HEX)
  end

  def test_conversion_to_string
    assert_equal VALUE_AS_HEX, @uuid.to_s
  end

  def test_version_is_accessible
    assert_equal 7, @uuid.version
  end

  def test_variant_is_accessible
    assert_equal 2, @uuid.variant
  end

  def test_value_is_accessible
    assert_equal VALUE_AS_INT, @uuid.value
  end

  def test_uuids_of_the_same_version_can_be_compared
    smaller = ::Uuid::Value.new(VALUE_AS_INT - 1)

    assert @uuid > smaller
    refute smaller > @uuid
    refute_equal @uuid, smaller
  end

  def test_uuids_of_different_versions_cannot_be_compared
    different = ::Uuid::Value.from("011f71fb-268d-6708-8102-030405060708")

    assert_nil @uuid <=> different
  end
end
