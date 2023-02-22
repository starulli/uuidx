# frozen_string_literal: true

require "test_helper"

class TestClockPrecisionChecks < Minitest::Test
  def test_uuid6_check_fails_for_greater_than_100_nanosecond_resolution
    with_clock_resolution(1000) do
      assert_raises(Uuidx::ClockResolutionError) { Uuidx::Version6.verify_clock_resolution! }
    end
  end

  def test_uuid6_check_passes_for_100_nanosecond_resolution
    with_clock_resolution(100) do
      assert Uuidx::Version6.verify_clock_resolution!
    end
  end

  def test_uuid6_check_passes_for_less_than_100_nanosecond_resolution
    with_clock_resolution(10) do
      assert Uuidx::Version6.verify_clock_resolution!
    end
  end

  def test_uuid7_check_fails_for_greater_than_1_millisecond_resolution
    with_clock_resolution(10) do
      assert_raises(Uuidx::ClockResolutionError) { Uuidx::Version7.verify_clock_resolution! }
    end
  end

  def test_uuid7_check_passes_for_1_millisecond_resolution
    with_clock_resolution(1) do
      assert Uuidx::Version7.verify_clock_resolution!
    end
  end

  def test_uuid7_check_passes_for_less_than_1_millisecond_resolution
    with_clock_resolution(0) do
      assert Uuidx::Version7.verify_clock_resolution!
    end
  end

  def with_clock_resolution(value, &block)
    Process.stub :clock_getres, value, &block
  end
end
