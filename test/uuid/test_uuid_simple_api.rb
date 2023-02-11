# frozen_string_literal: true

require "test_helper"

class TestUuidSimpleApi < Minitest::Test
  def uuid_regex(version)
    Regexp.new("[0-9a-f]{8}-[0-9a-f]{4}-#{version}[0-9a-f]{3}-[0-9a-f]{4}-[0-9a-f]{12}")
  end

  def test_uuid4_can_be_made
    assert_match uuid_regex(4), Uuid.v4
  end

  def test_uuid6_can_be_made
    assert_match uuid_regex(6), Uuid.v6
  end

  def test_uuid7_can_be_made
    assert_match uuid_regex(7), Uuid.v7
  end
end
