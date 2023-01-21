# frozen_string_literal: true

require "test_helper"

class UuidNextFormattingTest < Minitest::Test
  def test_standard_string_output
    assert_equal "00000000-0000-0000-0000-000000000000", ::Uuid::Next::NIL_UUID.to_s, "nil uuid wrong"
    assert_equal "ffffffff-ffff-ffff-ffff-ffffffffffff", ::Uuid::Next::MAX_UUID.to_s, "max uuid wrong"
  end

  def test_v6_string_output
    env_stubs do
      ::Uuid::Next::V6.reset_clock_seq!
      ::Uuid::Next::V6.reset_node_id!

      assert_equal "1b21dd21-3814-6000-8202-030405060708", ::Uuid::Next::V6.generate.to_s
    end
  end
end
