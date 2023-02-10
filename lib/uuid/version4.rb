# frozen_string_literal: true

require "securerandom"

module Uuid
  # UUID Version 7 defined by the
  # {RFC 4122 BIS-01 Draft}[https://www.ietf.org/archive/id/draft-ietf-uuidrev-rfc4122bis-01.html#name-uuid-version-4].
  #
  # To construct a new UUID v4 value create a generator, then use #generate.
  #   g = Uuid::Version4.new
  #   g.generate # => "2b54639d-e43e-489f-9c64-30ecdcac3c95"
  #
  # The implementation will cache 1024 bytes of random data from +SecureRandom+ to facilitate faster construction.
  class Version4
    VERSION_VARIANT = (0x4 << 76) | (0x2 << 62) # :nodoc:
    BUFFER_SIZE = 64 # :nodoc:
    NEEDED_BYTES = BUFFER_SIZE * 16 # :nodoc:
    UNPACK_FORMAT = "QQ" * BUFFER_SIZE # :nodoc:
    RANDOM_AB_MASK = 0xffffffff_ffff0fff # :nodoc:
    AB_SHIFT = 64 # :nodoc:
    RANDOM_C_MASK = 0x3fffffff_ffffffff # :nodoc:

    # Construct a UUID v4 generator.
    def initialize
      @pool = []
      @pool_lock = Mutex.new
    end

    # Construct a UUID v4 value.
    def generate
      ab, c = @pool_lock.synchronize do
        @pool = SecureRandom.bytes(NEEDED_BYTES).unpack(UNPACK_FORMAT) if @pool.empty?
        @pool.pop(2)
      end

      Uuid.format(VERSION_VARIANT | ((ab & RANDOM_AB_MASK) << AB_SHIFT) | (c & RANDOM_C_MASK))
    end
  end
end
