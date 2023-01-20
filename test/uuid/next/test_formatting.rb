# frozen_string_literal: true

require "test_helper"

class UuidNextFormattingTest < Minitest::Test
  def test_standard_string_output
    assert_equal "00000000-0000-0000-0000-000000000000", ::Uuid::Next::NIL_UUID.to_s, "nil uuid wrong"
    assert_equal "ffffffff-ffff-ffff-ffff-ffffffffffff", ::Uuid::Next::MAX_UUID.to_s, "max uuid wrong"
  end
end
