# frozen_string_literal: true

require "test_helper"

class TestNilUuid < Minitest::Test
  def test_uuid_is_correct
    assert_equal "00000000-0000-0000-0000-000000000000", Uuidx.nil_uuid
  end

  def test_nil_equals_nil
    assert_equal Uuidx.nil_uuid, Uuidx.nil_uuid
  end

  def test_nil_is_less_than_other_uuids
    generators = [
      Uuidx::Version4.new, Uuidx::Version6.new, Uuidx::Version7.new, Uuidx::Version8.new(OverflowingGeneratorDefinition)
    ]

    assert Uuidx.nil_uuid < Uuidx.max_uuid
    generators.each do |g|
      10_000.times { assert_operator Uuidx.nil_uuid, :<, g.generate }
    end
  end
end
