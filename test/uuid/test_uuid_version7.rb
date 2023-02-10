# frozen_string_literal: true

require "test_helper"

class TestUuidVersion7 < Minitest::Test
  TIME = 0x0102030405060708

  def setup
    Process.stub :clock_gettime, TIME do
      SecureRandom.stub :bytes, "\x0\x1\x2\x3\x4\x5\x6\x7\x8\x9\xa\xb\xc\xd\xe\xf" * 40 do
        g = Uuid::Version7.new
        @uuid = g.generate
      end
    end
  end

  def test_uuid_is_correct
    assert_equal "03040506-0708-7706-8f0e-0d0c0b0a0908", @uuid
  end

  def test_version_is_correct
    assert_equal "7", @uuid[14]
  end

  def test_variant_is_correct
    assert_equal "8", @uuid[19]
  end
end
