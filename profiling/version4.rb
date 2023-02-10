# frozen_string_literal: true

require_relative "../lib/uuid"

g = Uuid::Version4.new
100_000.times { g.generate }
