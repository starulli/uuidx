# frozen_string_literal: true

require_relative "../lib/uuidx"

g = Uuidx::Version7.new
100_000.times { g.generate }
