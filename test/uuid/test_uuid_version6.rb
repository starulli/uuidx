# frozen_string_literal: true

require "test_helper"

class TestUuidVersion6 < Minitest::Test
  def setup
    Process.stub :clock_gettime, 0xcba987654321 do
      SecureRandom.stub :bytes, "\x0\x1\x2\x3\x4\x5\x6\x7\x8\x9\xa\xb" do
        ::Uuid::Version6.send(:reset_node_id!)
        ::Uuid::Version6.send(:reset_clock_sequence!)
        @uuid = ::Uuid::Version6.generate
      end
    end
  end

  def test_uuid_is_correct
    assert_equal "1b21fdb7-3942-6ec0-8204-020304050607", @uuid.to_s
  end

  def test_version_is_correct
    assert_equal 6, @uuid.version
  end

  def test_variant_is_correct
    assert_equal 2, @uuid.variant
  end
end
