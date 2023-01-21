# frozen_string_literal: true

require "securerandom"
require_relative "abstract_uuid"

class Uuid::Next::V6 < Uuid::Next::AbstractUuid
  class << self
    GREGORIAN_TO_UNIX_NS_TENTHS = 122_192_928_000_000_000

    attr_reader :clock_seq, :node_id

    def clock_seq_next
      @clock_seq = (clock_seq + 1) & 0x3fff
    end

    def reset_clock_seq!
      @clock_seq = SecureRandom.bytes(4).unpack1("L")
    end

    def reset_node_id!
      @node_id = SecureRandom.bytes(8).unpack1("Q>") & 0xffffffffffff
    end

    def generate
      seq = clock_seq_next
      variant_clk_high = (0x80 | ((seq >> 8) & 0x3f)) << 56
      clk_low = (seq & 0xff) << 48

      new(versioned_gregorian_ts | variant_clk_high | clk_low | node_id)
    end

    def versioned_gregorian_ts
      t = GREGORIAN_TO_UNIX_NS_TENTHS + (Process.clock_gettime(:CLOCK_REALTIME, :nanosecond) / 100)
      ts_high_mid = ((t >> 12) & 0xffffffffffff) << 80
      version_ts_low = (0x6000 | (t & 0xfff)) << 64

      ts_high_mid | version_ts_low
    end
    private :versioned_gregorian_ts
  end

  reset_clock_seq!
  reset_node_id!

  def initialize(bytes)
    super()
    self.value = bytes
  end
end
