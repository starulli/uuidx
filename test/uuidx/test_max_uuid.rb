# frozen_string_literal: true

require "test_helper"

class TestMaxUuid < Minitest::Test
  def test_uuid_is_correct
    assert_equal "ffffffff-ffff-ffff-ffff-ffffffffffff", Uuidx.max_uuid
  end

  def test_max_equals_max
    assert_equal Uuidx.max_uuid, Uuidx.max_uuid
  end

  def test_max_is_greater_than_other_uuids
    generators = [
      Uuidx::Version4.new, Uuidx::Version6.new, Uuidx::Version7.new, Uuidx::Version8.new(OverflowingGeneratorDefinition)
    ]

    assert Uuidx.max_uuid > Uuidx.nil_uuid
    generators.each do |g|
      10_000.times { assert_operator Uuidx.max_uuid, :>, g.generate }
    end
  end
end
