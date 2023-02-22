# frozen_string_literal: true

require_relative "../lib/uuidx"

g = Uuidx::Version4.new
100_000.times { g.generate }
