# frozen_string_literal: true

require "test_helper"

class TestUuidVersion7 < Minitest::Test
  def setup
    Process.stub :clock_gettime, 0xcba987654321 do
      SecureRandom.stub :bytes, "\x0\x1\x2\x3\x4\x5\x6\x7\x8\x9\xa\xb\xc\xd\xe\xf" * 40 do
        g = Uuid::Version7.new
        @uuid = g.generate
      end
    end
  end

  def test_uuid_is_correct
    assert_equal "cba98765-4321-7607-8809-0a0b0c0d0e0f", @uuid.to_s
  end

  def test_version_is_correct
    assert_equal 7, @uuid.version
  end

  def test_variant_is_correct
    assert_equal 2, @uuid.variant
  end
end
