# frozen_string_literal: true

module Uuid
  # UUID Version 8 defined by {RFC 4122 BIS-00 Draft
  # }[https://www.ietf.org/archive/id/draft-ietf-uuidrev-rfc4122bis-00.html#name-uuid-version-8].
  #
  # Since UUID Version 8 is entirely custom to your application, first create a generator module.
  #   module MyGenerator
  #     def self.custom_a
  #       1
  #     end
  #
  #     def self.custom_b
  #       2
  #     end
  #
  #     def self.custom_c
  #       3
  #     end
  #   end
  #
  # Then register this module to be used by the library.
  #   Uuid::Version8.generator = MyGenerator
  #
  # To construct a new UUID Version 8 use ::generate
  #   Uuid::Version8.generate # => <Uuid::Value ...>
  #
  # The implementation will truncate the results of each generator module method so that they abide by the bit lengths
  # of the UUID specification.
  #
  # There is no default implementation of UUID Version 8.
  module Version8
    VERSION = 0x8 << 76 # :nodoc:
    VARIANT = 0x2 << 62 # :nodoc:

    # Construct a UUID Version 8 Value.
    def self.generate
      a = (@generator.custom_a & 0xffffffffffff) << 80
      b = (@generator.custom_b & 0xfff) << 64
      c = (@generator.custom_c & 0x3fffffffffffffff)
      Value.new a | VERSION | b | VARIANT | c
    end

    # Register the generator module for creating a UUID Version 8 Value.
    #
    # ===== Parameters
    # +generator_module+ - A module implementing the +custom_a+, +custom_b+, and +custom_c+ methods.
    def self.generator=(generator_module)
      @generator = generator_module
    end
  end
end
