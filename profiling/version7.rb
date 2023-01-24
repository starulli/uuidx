require_relative "../lib/uuid"

100_000.times { Uuid::Version7.generate }