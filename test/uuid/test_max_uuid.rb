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
    generators = [
      Uuid::Version4.new, Uuid::Version6.new, Uuid::Version7.new, Uuid::Version8.new(OverflowingGeneratorDefinition)
    ]

    assert Uuid.max_uuid > Uuid.nil_uuid
    generators.each do |g|
      10_000.times { assert_operator Uuid.max_uuid, :>, g.generate }
    end
  end
end
