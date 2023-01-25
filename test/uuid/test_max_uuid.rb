# frozen_string_literal: true

require "test_helper"

class TestMaxUuid < Minitest::Test
  def test_uuid_is_correct
    assert_equal "ffffffff-ffff-ffff-ffff-ffffffffffff", Uuid::Max.to_s
  end

  def test_max_equals_max
    assert_equal Uuid::Max, Uuid::Max
  end

  def test_max_is_greater_than_other_uuids
    Uuid::Version8.generator = ::OverflowingGenerator

    assert Uuid::Max > Uuid::Nil
    100_000.times { assert Uuid::Max > Uuid::Version6.generate }
    100_000.times { assert Uuid::Max > Uuid::Version7.generate }
    100_000.times { assert Uuid::Max > Uuid::Version8.generate }
  end
end
