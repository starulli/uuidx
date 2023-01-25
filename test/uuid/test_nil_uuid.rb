# frozen_string_literal: true

require "test_helper"

class TestNilUuid < Minitest::Test
  def test_uuid_is_correct
    assert_equal "00000000-0000-0000-0000-000000000000", Uuid::Nil.to_s
  end

  def test_nil_equals_nil
    assert_equal Uuid::Nil, Uuid::Nil
  end

  def test_nil_is_less_than_other_uuids
    Uuid::Version8.generator = ::OverflowingGenerator

    assert Uuid::Nil < Uuid::Max
    100_000.times { assert Uuid::Nil < Uuid::Version6.generate }
    100_000.times { assert Uuid::Nil < Uuid::Version7.generate }
    100_000.times { assert Uuid::Nil < Uuid::Version8.generate }
  end
end
