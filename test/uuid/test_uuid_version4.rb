# frozen_string_literal: true

require "test_helper"

class TestUuidVersion4 < Minitest::Test
  def setup
    SecureRandom.stub :bytes, "\x0\x1\x2\x3\x4\x5\x6\x7\x8\x9\xa\xb\xc\xd\xe\xf" * 64 do
      g = Uuid::Version4.new
      @uuid = g.generate
    end
  end

  def test_uuid_is_correct
    assert_equal "07060504-0302-4100-8f0e-0d0c0b0a0908", @uuid
  end

  def test_version_is_correct
    assert_equal "4", @uuid[14]
  end

  def test_variant_is_correct
    assert_equal "8", @uuid[19]
  end
end
