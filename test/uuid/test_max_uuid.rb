# frozen_string_literal: true

require "test_helper"

class TestMaxUuid < Minitest::Test
  def test_uuid_is_correct
    assert_equal "ffffffff-ffff-ffff-ffff-ffffffffffff", Uuid::MAX.to_s
  end

  def test_max_equals_max
    assert_equal Uuid::MAX, Uuid::MAX
  end

  def test_max_is_greater_than_other_uuids
    Uuid::Version8.generator = ::OverflowingGenerator

    100_000.times { assert Uuid::MAX > Uuid::Version6.generate }
    100_000.times { assert Uuid::MAX > Uuid::Version7.generate }
    100_000.times { assert Uuid::MAX > Uuid::Version8.generate }
  end
end
