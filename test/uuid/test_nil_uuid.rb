# frozen_string_literal: true

require "test_helper"

class TestNilUuid < Minitest::Test
  def test_uuid_is_correct
    assert_equal "00000000-0000-0000-0000-000000000000", Uuid.nil_uuid
  end

  def test_nil_equals_nil
    assert_equal Uuid.nil_uuid, Uuid.nil_uuid
  end

  def test_nil_is_less_than_other_uuids
    gen6 = Uuid::Version6.new
    gen7 = Uuid::Version7.new
    gen8 = Uuid::Version8.new(OverflowingGeneratorDefinition)

    assert Uuid.nil_uuid < Uuid.max_uuid
    100_000.times { assert Uuid.nil_uuid < gen6.generate }
    100_000.times { assert Uuid.nil_uuid < gen7.generate }
    100_000.times { assert Uuid.nil_uuid < gen8.generate }
  end
end
