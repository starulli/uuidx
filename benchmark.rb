# frozen_string_literal: true

require "securerandom"
require "benchmark/ips"
require "uuid"

Benchmark.ips do |b|
  gen6 = Uuid::Version6.new
  gen7 = Uuid::Version7.new

  b.report("stdlib") { SecureRandom.uuid }
  b.report("uuid6") { gen6.generate }
  b.report("uuid7") { gen7.generate }
  b.compare!
end
