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
    gen6 = Uuid::Version6.new
    gen7 = Uuid::Version7.new
    gen8 = OverflowingV8Generator.new

    assert Uuid::Nil < Uuid::Max
    100_000.times { assert Uuid::Nil < gen6.generate }
    100_000.times { assert Uuid::Nil < gen7.generate }
    100_000.times { assert Uuid::Nil < gen8.generate }
  end
end
