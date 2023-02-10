# frozen_string_literal: true

module Uuid
  # UUID Version 8 defined by the
  # {RFC 4122 BIS-01 Draft}[https://www.ietf.org/archive/id/draft-ietf-uuidrev-rfc4122bis-01.html#name-uuid-version-8].
  #
  # Since UUID v8 is entirely custom to your application, first create a generator definition class.
  #   class MyGeneratorDefinition
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
  # The requirements for each method are:
  #
  # - +custom_a+ should generate a 48-bit value which will be the most significant 6 octets.
  # - +custom_b+ should generate a 12-bit value which is placed between the version and variant bits.
  # - +custom_c+ should generate a 62-bit value which acts as the remaining least significant octets.
  #
  # Then create a UUID v8 generator by passing in the class, and call #generate.
  #   g = Uuid::Version8.new(MyGeneratorDefinition)
  #   g.generate # => "00000000-0001-8002-8000-000000000003"
  #
  # The implementation will truncate the results of each generator module method so that they abide by the bit lengths
  # of the UUID specification.
  #
  # There is no default implementation of UUID v8.
  class Version8
    VERSION_VARIANT = (0x8 << 76) | (0x2 << 62) # :nodoc:
    CUSTOM_A_MASK = 0xffff_ffffffff # :nodoc:
    CUSTOM_B_MASK = 0xfff # :nodoc:
    CUSTOM_C_MASK = 0x3fffffff_ffffffff # :nodoc:
    A_SHIFT = 16 # :nodoc:
    HIGH_SHIFT = 64 # :nodoc:

    # Construct a UUID v8 generator.
    def initialize(definition_class)
      @definition = definition_class.new
    end

    # Construct a UUID v8 value.
    def generate
      a = @definition.custom_a & CUSTOM_A_MASK
      b = @definition.custom_b & CUSTOM_B_MASK
      high = (a << A_SHIFT) | b
      c = @definition.custom_c & CUSTOM_C_MASK

      Uuid.format(VERSION_VARIANT | (high << HIGH_SHIFT) | c)
    end
  end
end
