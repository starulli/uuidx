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
    generators = [
      Uuid::Version4.new, Uuid::Version6.new, Uuid::Version7.new, Uuid::Version8.new(OverflowingGeneratorDefinition)
    ]

    assert Uuid.nil_uuid < Uuid.max_uuid
    generators.each do |g|
      10_000.times { assert_operator Uuid.nil_uuid, :<, g.generate }
    end
  end
end
