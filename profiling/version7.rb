require_relative "../lib/uuid"

g = Uuid::Version7.new
100_000.times { g.generate }
