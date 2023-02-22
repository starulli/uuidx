# frozen_string_literal: true

require "test_helper"

class TestUuidBatchApi < Minitest::Test
  def uuid_regex(version)
    Regexp.new("[0-9a-f]{8}-[0-9a-f]{4}-#{version}[0-9a-f]{3}-[0-9a-f]{4}-[0-9a-f]{12}")
  end

  def test_uuid4_batches_can_be_made
    assert_match uuid_regex(4), Uuidx.batch_v4(1).first
  end

  def test_uuid6_batches_can_be_made
    assert_match uuid_regex(6), Uuidx.batch_v6(1).first
  end

  def test_uuid7_batches_can_be_made
    assert_match uuid_regex(7), Uuidx.batch_v7(1).first
  end

  def test_batches_return_the_correct_amount
    assert_equal 3, Uuidx.batch_v4(3).length
  end

  def test_uuid6_batch_is_monotonic
    result = Uuidx.batch_v6(50)

    result.each_cons(2) do |a, b|
      assert_operator a, :<, b
    end
  end

  def test_uuid7_batch_is_monotonic
    result = Uuidx.batch_v7(50)

    result.each_cons(2) do |a, b|
      assert_operator a, :<, b
    end
  end
end
