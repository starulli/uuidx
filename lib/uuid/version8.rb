# frozen_string_literal: true

module Uuid
  # UUID Version 8 defined by {RFC 4122 BIS-00 Draft
  # }[https://www.ietf.org/archive/id/draft-ietf-uuidrev-rfc4122bis-00.html#name-uuid-version-8].
  #
  # Since UUID Version 8 is entirely custom to your application, first create a generator class.
  #   class MyGenerator < Uuid::Version8
  #     def custom_a
  #       1
  #     end
  #
  #     def custom_b
  #       2
  #     end
  #
  #     def custom_c
  #       3
  #     end
  #   end
  #
  # Then create your generator
  #   g = MyGenerator.new
  #
  # To construct a new UUID Version 8 use #generate
  #   g.generate # => <Uuid::Value ...>
  #
  # The implementation will truncate the results of each generator module method so that they abide by the bit lengths
  # of the UUID specification.
  #
  # There is no default implementation of UUID Version 8.
  class Version8
    VERSION = 0x8 << 76 # :nodoc:
    VARIANT = 0x2 << 62 # :nodoc:

    # Construct a UUID Version 8 Value.
    def generate
      a = (custom_a & 0xffffffffffff) << 80
      b = (custom_b & 0xfff) << 64
      c = (custom_c & 0x3fffffffffffffff)
      Value.new a | VERSION | b | VARIANT | c
    end

    # Generate a 48-bit value that acts as the most significant bytes.
    def custom_a
      raise NotImplementedError
    end

    # Generate a 12-bit value that appears between the version and variant.
    def custom_b
      raise NotImplementedError
    end

    # Generate a 62-bit value for the least significant bytes.
    def custom_c
      raise NotImplementedError
    end
  end
end
