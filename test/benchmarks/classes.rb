# frozen_string_literal: true

require "securerandom"
require "benchmark/ips"
require "uuidx"

Benchmark.ips do |b|
  gen4 = Uuidx::Version4.new
  gen6 = Uuidx::Version6.new
  gen7 = Uuidx::Version7.new

  b.report("stdlib") { SecureRandom.uuid }
  b.report("uuid4") { gen4.generate }
  b.report("uuid6") { gen6.generate }
  b.report("uuid7") { gen7.generate }
  b.compare!
end
