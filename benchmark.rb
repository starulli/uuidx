# frozen_string_literal: true

require "securerandom"
require "benchmark/ips"
require "uuid/next"
require "uuid"

class ConstantUuid < Uuid::Next::V8
  class << self
    def custom_a
      1
    end

    def custom_b
      2
    end

    def custom_c
      3
    end
  end
end

Benchmark.ips do |b|
  b.report("stdlib") { SecureRandom.uuid }
  b.report("uuidv6") { Uuid::Next::V6.generate }
  b.report("uuidv7") { Uuid::Next::V7.generate }
  b.report("uuidv8") { ConstantUuid.generate }
  b.report("uuid6") { Uuid::Version6.generate }
  b.report("uuid7") { Uuid::Version7.generate }
  b.compare!
end
