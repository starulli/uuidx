# frozen_string_literal: true

require "securerandom"

class Uuid::Next::V7 < Uuid::Next::AbstractUuid
  class << self
    VERSION = 0x7 << 76
    VARIANT = 0x2 << 62

    def generate
      a, b = byte_pool
      ts = (Process.clock_gettime(:CLOCK_REALTIME, :millisecond) & 0xffffffffffff) << 80
      new(ts | VERSION | ((a & 0xfff) << 64) | VARIANT | (b & 0x3fffffffffffffff))
    end

    BUFFER_SIZE = 64
    NEEDED_BYTES = BUFFER_SIZE * 10
    UNPACK_FORMAT = "S>Q>" * BUFFER_SIZE

    def byte_pool
      refill_pool! if @pool.empty?
      @pool.pop(2)
    end

    def refill_pool!
      @pool = SecureRandom.bytes(NEEDED_BYTES).unpack(UNPACK_FORMAT)
    end
  end

  refill_pool!

  def initialize(bytes)
    super()
    self.value = bytes
  end
end
