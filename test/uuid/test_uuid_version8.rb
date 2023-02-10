# frozen_string_literal: true

require "test_helper"

class TestUuidVersion8 < Minitest::Test
  def setup
    @uuid = Uuid::Version8.new(OverflowingGeneratorDefinition).generate
  end

  def test_uuid_is_correct
    assert_equal "00000000-0001-8002-8000-000000000003", @uuid
  end

  def test_version_is_correct
    assert_equal "8", @uuid[14]
  end

  def test_variant_is_correct
    assert_equal "8", @uuid[19]
  end
end
