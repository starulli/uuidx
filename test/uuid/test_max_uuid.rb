# frozen_string_literal: true

require "test_helper"

class TestMaxUuid < Minitest::Test
  def test_uuid_is_correct
    assert_equal "ffffffff-ffff-ffff-ffff-ffffffffffff", Uuid.max_uuid
  end

  def test_max_equals_max
    assert_equal Uuid.max_uuid, Uuid.max_uuid
  end

  def test_max_is_greater_than_other_uuids
    gen6 = Uuid::Version6.new
    gen7 = Uuid::Version7.new
    gen8 = Uuid::Version8.new(OverflowingGeneratorDefinition)

    assert Uuid.max_uuid > Uuid.nil_uuid
    100_000.times { assert Uuid.max_uuid > gen6.generate }
    100_000.times { assert Uuid.max_uuid > gen7.generate }
    100_000.times { assert Uuid.max_uuid > gen8.generate }
  end
end
