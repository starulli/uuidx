# frozen_string_literal: true

require "securerandom"
require "benchmark/ips"
require "uuid"

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

Benchmark.ips do |b|
  gen6 = Uuid::Version6.new

  b.report("stdlib") { SecureRandom.uuid }
  b.report("uuid6") { gen6.generate }
  b.report("uuid7") { Uuid::Version7.generate }
  # b.report("uuid8") { Uuid::Version8.generate }
  b.compare!
end
