# frozen_string_literal: true

require "securerandom"

module Uuid
  # UUID Version 7 defined by {RFC 4122 BIS-00 Draft
  # }[https://www.ietf.org/archive/id/draft-ietf-uuidrev-rfc4122bis-00.html#name-uuid-version-7].
  #
  # To construct a new UUID v7 Value use ::generate
  #   Uuid::Version7.generate # => <Uuid::Value ...>
  #
  # The implementation will cache 640 bytes of random data from +SecureRandom+ to facilitate
  # faster construction.
  module Version7
    VERSION = 0x7 << 76 # :nodoc:
    VARIANT = 0x2 << 62 # :nodoc:

    # Construct a UUID Version 7 Value.
    def self.generate
      a, b = byte_pool
      ts = (Process.clock_gettime(:CLOCK_REALTIME, :millisecond) & 0xffffffffffff) << 80
      Value.new ts | VERSION | ((a & 0xfff) << 64) | VARIANT | (b & 0x3fffffffffffffff)
    end

    BUFFER_SIZE = 64 # :nodoc:
    NEEDED_BYTES = BUFFER_SIZE * 10 # :nodoc:
    UNPACK_FORMAT = "S>Q>" * BUFFER_SIZE # :nodoc:
    @pool = []

    def self.byte_pool
      refill_pool! if @pool.empty?
      @pool.pop(2)
    end

    def self.refill_pool!
      @pool = SecureRandom.bytes(NEEDED_BYTES).unpack(UNPACK_FORMAT)
    end

    private_class_method :byte_pool, :refill_pool!
  end
end
