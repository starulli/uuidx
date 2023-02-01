# frozen_string_literal: true

require "securerandom"

module Uuid
  # UUID Version 6 defined by {RFC 4122 BIS-01 Draft
  # }[https://www.ietf.org/archive/id/draft-ietf-uuidrev-rfc4122bis-01.html#name-uuid-version-6].
  #
  # To construct a new UUID Version 6 Value use #generate
  #   Uuid::Version6.generate # => <Uuid::Value ...>
  #
  # The implementation will use +SecureRandom+ to populate the Node and Clock Sequence bits with a random value
  # at module load time.
  #
  # Generation is thread-safe, but if you are using multi-process clusters you should call #reset! at the start
  # of each process to reduce the chance of two processes generating the same value.
  class Version6
    VERSION = 0x6 << 76 # :nodoc:
    VARIANT = 0x2 << 62 # :nodoc:
    GREGORIAN_MICROSECOND_TENTHS = 122_192_928_000_000_000 # :nodoc:

    # Construct a new UUID v6 generator.
    def initialize
      @seq_lock = Mutex.new
      reset!
    end

    # Construct a UUID Version 6 Value.
    def generate
      ts = GREGORIAN_MICROSECOND_TENTHS + (Process.clock_gettime(Process::CLOCK_REALTIME, :nanosecond) / 100)
      seq = @seq_lock.synchronize do
        @clock_sequence += 1 if ts <= @last_ts
        @last_ts = ts
        @clock_sequence
      end

      ts_high_mid = ((ts >> 12) & 0xffffffffffff) << 80
      ts_low = (ts & 0xfff) << 64
      seq = (seq & 0x3fff) << 48

      Value.new ts_high_mid | VERSION | ts_low | VARIANT | seq | @node_id
    end

    # Reset the generator with a new random node ID and clock sequence.
    #
    # This method is not thread-safe and should only be called at application or child process start.
    def reset!
      @last_ts = 0
      @node_id = SecureRandom.bytes(8).unpack1("Q>") & 0xffffffffffff
      @clock_sequence = SecureRandom.bytes(4).unpack1("L>")
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
