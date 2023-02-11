# frozen_string_literal: true

require "securerandom"
require "benchmark/ips"
require "uuid"

Benchmark.ips do |b|
  b.report("stdlib") { SecureRandom.uuid }
  b.report("uuid4") { Uuid.v4 }
  b.report("uuid6") { Uuid.v6 }
  b.report("uuid7") { Uuid.v7 }
  b.compare!
end
