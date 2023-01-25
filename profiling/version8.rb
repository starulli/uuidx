require_relative "../lib/uuid"

module ConstantGenerator
  def self.custom_a
    1
  end

  def self.custom_b
    2
  end

  def self.custom_c
    3
  end
end

Uuid::Version8.generator = ConstantGenerator

100_000.times { Uuid::Version8.generate }