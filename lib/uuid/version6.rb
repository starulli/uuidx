# frozen_string_literal: true

require "securerandom"

module Uuid
  # UUID Version 7 defined by {RFC 4122 BIS-00 Draft
  # }[https://www.ietf.org/archive/id/draft-ietf-uuidrev-rfc4122bis-00.html#name-uuid-version-6].
  #
  # To construct a new UUID Version 6 Value use ::generate
  #   Uuid::Version6.generate # => <Uuid::Value ...>
  #
  # The implementation will use +SecureRandom+ to populate the Node and Clock Sequence bits with a random value
  # at module load time.
  module Version6
    VERSION = 0x6 << 76 # :nodoc:
    VARIANT = 0x2 << 62 # :nodoc:
    GREGORIAN_MICROSECOND_TENTHS = 122_192_928_000_000_000 # :nodoc:

    # Construct a UUID Version 6 Value.
    def self.generate
      ts = GREGORIAN_MICROSECOND_TENTHS + (Process.clock_gettime(:CLOCK_REALTIME, :nanosecond) / 100)
      ts_high_mid = ((ts >> 12) & 0xffffffffffff) << 80
      ts_low = (ts & 0xfff) << 64

      @clock_sequence += 1
      seq = (@clock_sequence & 0x3fff) << 48

      Value.new ts_high_mid | VERSION | ts_low | VARIANT | seq | @node_id
    end

    def self.reset_node_id!
      @node_id = SecureRandom.bytes(8).unpack1("Q>") & 0xffffffffffff
    end

    def self.reset_clock_sequence!
      @clock_sequence = SecureRandom.bytes(4).unpack1("L>")
    end

    private_class_method :reset_node_id!, :reset_clock_sequence!

    reset_node_id!
    reset_clock_sequence!
  end
end
