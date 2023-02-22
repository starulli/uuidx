# frozen_string_literal: true

require "securerandom"
require "benchmark/ips"
require "uuidx"

Benchmark.ips do |b|
  b.report("stdlib") { SecureRandom.uuid }
  b.report("uuid4") { Uuidx.v4 }
  b.report("uuid6") { Uuidx.v6 }
  b.report("uuid7") { Uuidx.v7 }
  b.compare!
end
