# frozen_string_literal: true

require "securerandom"

module Uuid
  # UUID Version 6 defined by the
  # {RFC 4122 BIS-01 Draft}[https://www.ietf.org/archive/id/draft-ietf-uuidrev-rfc4122bis-01.html#name-uuid-version-6].
  #
  # To construct a new UUID v6 value create a generator, then use #generate.
  #   g = Uuid::Version6.new
  #   g.generate # => "1eda9761-9f6f-6414-8c5f-fd61f1239907"
  #
  # The implementation will use +SecureRandom+ to populate the Node and Clock Sequence bits with a random value
  # at module load time.
  #
  # Generation is thread-safe, but if you are using multi-process clusters you should call #reset! at the start
  # of each process to reduce the chance of two processes generating the same value.
  class Version6
    VERSION_VARIANT = (0x6 << 76) + (0x2 << 62) # :nodoc:
    GREGORIAN_MICROSECOND_TENTHS = 122_192_928_000_000_000 # :nodoc:
    CLOCK_SEQ_SHIFT = 48 # :nodoc:
    CLOCK_SEQ_INCREMENT = 1 << CLOCK_SEQ_SHIFT # :nodoc:
    CLOCK_SEQ_MASK = 0x3fff << CLOCK_SEQ_SHIFT # :nodoc:
    TS_NS_FACTOR = 100 # :nodoc:
    TS_LOW_MASK = 0xfff # :nodoc:
    TS_HIGH_MID_MASK = 0xffffffff_ffff0000 # :nodoc:
    TS_MASK_SHIFT = 4 # :nodoc:
    TS_POSITIONAL_SHIFT = 64 # :nodoc:
    NODE_ID_MASK   = 0xffff_ffffffff # :nodoc:
    NODE_ID_MC_BIT = 0x0100_00000000 # :nodoc:

    # Construct a new UUID v6 generator.
    def initialize
      reset!
    end

    # Construct a UUID v6 value.
    def generate
      @clock_sequence = (@clock_sequence + CLOCK_SEQ_INCREMENT) & CLOCK_SEQ_MASK

      ts = GREGORIAN_MICROSECOND_TENTHS + (Process.clock_gettime(Process::CLOCK_REALTIME, :nanosecond) / TS_NS_FACTOR)
      ts = ((ts << TS_MASK_SHIFT) & TS_HIGH_MID_MASK) | (ts & TS_LOW_MASK)

      Uuid.format(VERSION_VARIANT | (ts << TS_POSITIONAL_SHIFT) | @clock_sequence | @node_id)
    end

    # Reset the generator with a new random node ID and clock sequence.
    #
    # This method is not thread-safe and should only be called at application or child process start.
    def reset!
      @node_id = (SecureRandom.bytes(8).unpack1("Q") & NODE_ID_MASK) | NODE_ID_MC_BIT
      @clock_sequence = SecureRandom.bytes(4).unpack1("L") << CLOCK_SEQ_SHIFT
    end

    # Verify that the clock resolution is capable of 100ns resolution.
    #
    # Raises ClockResolutionError when the clock resolution is insufficient.
    def self.verify_clock_resolution!
      ns_res = Process.clock_getres(Process::CLOCK_REALTIME, :nanosecond)
      raise ClockResolutionError, "Detected #{ns_res}ns resolution, need <= 100ns" if ns_res > 100

      true
    end
  end
end
