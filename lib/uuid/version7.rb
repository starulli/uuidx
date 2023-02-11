# frozen_string_literal: true

require "securerandom"

module Uuid
  # UUID Version 7 defined by the
  # {RFC 4122 BIS-01 Draft}[https://www.ietf.org/archive/id/draft-ietf-uuidrev-rfc4122bis-01.html#name-uuid-version-7].
  #
  # To construct a new UUID v7 value create a generator, then use #generate.
  #   g = Uuid::Version7.new
  #   g.generate # => "01863d24-6d1e-78ba-92ee-6e80c79c4e28"
  #
  # The implementation will cache 640 bytes of random data from +SecureRandom+ to facilitate faster construction.
  #
  # If you have need to make sure that the clock resolution is sufficient for the v7 specification
  # you can call ::verify_clock_resolution! and handle the ClockResolutionError as you see fit.
  #
  #   begin
  #     Uuid::Version7.verify_clock_resolution!
  #   rescue Uuid::ClockResolutionError
  #     # ...
  #   end
  #
  # The necessary clock resolution for v6 is 1ms.
  #
  # ===== A Note on Clock Timings
  # To combat clock drift, leap-second smearing, and other clock value changes that can appear without
  # requiring additional compute cost this implementation relies on secure random data to have sufficient
  # variation such that all generated UUIDs within 1ms have a low probability of collision.
  #
  # For a 0.001% chance of collision, the 74 bits of random data will require between 6.1×10^6 and 4.0×10^11
  # UUIDs to be generated in 1ms.
  class Version7
    VERSION_VARIANT = (0x7 << 76) | (0x2 << 62) # :nodoc:
    BUFFER_SIZE = 64 # :nodoc:
    NEEDED_BYTES = BUFFER_SIZE * 10 # :nodoc:
    UNPACK_FORMAT = "SQ" * BUFFER_SIZE # :nodoc:
    TS_MASK = 0xffff_ffffffff # :nodoc:
    RAND_A_MASK = 0xfff # :nodoc:
    RAND_B_MASK = 0x3fffffff_ffffffff # :nodoc:
    TS_SHIFT = 16 # :nodoc:
    HIGH_SHIFT = 64 # :nodoc:

    # Construct a UUID v7 generator.
    def initialize
      @pool = []
    end

    # Construct a UUID v7 value.
    def generate
      @pool = SecureRandom.bytes(NEEDED_BYTES).unpack(UNPACK_FORMAT) if @pool.empty?
      a, b = @pool.pop(2)
      ts = Process.clock_gettime(Process::CLOCK_REALTIME, :millisecond) & TS_MASK
      high = (ts << TS_SHIFT) | (a & RAND_A_MASK)

      Uuid.format(VERSION_VARIANT | (high << HIGH_SHIFT) | (b & RAND_B_MASK))
    end

    # Verify that the clock resolution is capable of 1ms resolution.
    #
    # Raises ClockResolutionError when the clock resolution is insufficient.
    def self.verify_clock_resolution!
      ms_res = Process.clock_getres(Process::CLOCK_REALTIME, :millisecond)
      raise ClockResolutionError, "Detected #{ms_res}ms resolution, need <= 1ms" if ms_res > 1

      true
    end
  end
end
