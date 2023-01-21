# frozen_string_literal: true

require "securerandom"

class Uuid::Next::V7 < Uuid::Next::AbstractUuid
  class << self
    VERSION = 0x7 << 76
    VARIANT = 0x2 << 62

    def generate
      a, b = SecureRandom.bytes(10).unpack("S>Q>")
      ts = (Process.clock_gettime(:CLOCK_REALTIME, :millisecond) & 0xffffffffffff) << 80
      new(ts | VERSION | ((a & 0xfff) << 64) | VARIANT | b & 0x3fffffffffffffff)
    end
  end

  def initialize(bytes)
    super()
    self.value = bytes
  end
end
