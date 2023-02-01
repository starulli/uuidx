# frozen_string_literal: true

require "securerandom"

module Uuid
  # UUID Version 7 defined by {RFC 4122 BIS-00 Draft
  # }[https://www.ietf.org/archive/id/draft-ietf-uuidrev-rfc4122bis-00.html#name-uuid-version-7].
  #
  # To construct a new UUID v7 Value use #generate
  #   Uuid::Version7.generate # => <Uuid::Value ...>
  #
  # The implementation will cache 640 bytes of random data from +SecureRandom+ to facilitate
  # faster construction.
  class Version7
    VERSION = 0x7 << 76 # :nodoc:
    VARIANT = 0x2 << 62 # :nodoc:
    BUFFER_SIZE = 64 # :nodoc:
    NEEDED_BYTES = BUFFER_SIZE * 10 # :nodoc:
    UNPACK_FORMAT = "S>Q>" * BUFFER_SIZE # :nodoc:

    # Construct a UUID v7 generator.
    def initialize
      @pool = []
      @pool_lock = Mutex.new
    end

    # Construct a UUID Version 7 Value.
    def generate
      a, b = @pool_lock.synchronize do
        @pool = SecureRandom.bytes(NEEDED_BYTES).unpack(UNPACK_FORMAT) if @pool.empty?
        @pool.pop(2)
      end
      ts = (Process.clock_gettime(:CLOCK_REALTIME, :millisecond) & 0xffffffffffff) << 80
      Value.new ts | VERSION | ((a & 0xfff) << 64) | VARIANT | (b & 0x3fffffffffffffff)
    end

    # Verify that the clock resolution is capable of 1ms resolution.
    #
    # Raises ClockResolutionError when the clock resolution is insufficient.
    def self.verify_clock_resolution!
      ms_res = Process.clock_getres(:CLOCK_REALTIME, :millisecond)
      raise ClockResolutionError, "Detected #{ms_res}ms resolution, need <= 1ms" if ms_res > 1

      true
    end
  end
end
