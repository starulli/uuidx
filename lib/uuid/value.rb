# frozen_string_literal: true

module Uuid
  # A representation of a 128-bit UUID.
  #
  # To construct a UUID from existing data, use ::from
  #   id = Uuid::Value.from("011f71fb-268d-7708-8102-030405060708")
  # or if you have integer data simply construct with ::new
  #   id = Uuid::Value.new(0x011f71fb268d77088102030405060708)
  #
  # Once you have a Value you can obtain the numeric representation with #value
  #   id.value # => 0x011f71fb268d77088102030405060708
  # or the numeric #version
  #   id.version # => 7
  # or convert it into a hex string via #to_s
  #   id.to_s # => "011f71fb-268d-7708-8102-030405060708"
  # or compare it to other Value objects of the same +version+
  #   smaller_id = Uuid::Value.new(id.value - 1)
  #   id > smaller_id # => true
  class Value
    include Comparable

    # Construct a Value from an existing, _valid_ hex +String+ representation.
    #
    # No validation is done to ensure the UUID is a valid format.
    #
    # ==== Parameters
    # * <tt>hexstring</tt> - A hexadecimal +String+ representing a valid UUID.
    def self.from(hexstring)
      new(hexstring.gsub("-", "").to_i(16))
    end

    # An +Integer+ representation of the Value.
    attr_reader :value

    # Construct a Value from an existing, _valid_ +Integer+ representation.
    #
    # No validation is done to ensure the UUID is a valid format.
    #
    # ==== Parameters
    # * <tt>value</tt> - An +Integer+ representing a valid UUID.
    def initialize(value)
      @value = value
    end

    # Convert the Value to a standard dash-delimited hex +String+.
    def to_s
      b = +value.to_s(16).rjust(32, "0")
      b.insert(8, "-")
      b.insert(13, "-")
      b.insert(18, "-")
      b.insert(23, "-")
      b.freeze
    end

    # The UUID version as an +Integer+.
    def version
      (value >> 76) & 0xf
    end

    def variant
      (value >> 62) & 0x3
    end

    # :nodoc:
    def <=>(other)
      return nil if version != other.version

      value <=> other.value
    end
  end
end
