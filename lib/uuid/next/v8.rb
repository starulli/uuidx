# frozen_string_literal: true

class Uuid::Next::V8 < Uuid::Next::AbstractUuid
  class << self
    VERSION = 0x8 << 76
    VARIANT = 0x2 << 62

    def generate
      a = (custom_a & 0xffffffffffff) << 80
      b = (custom_b & 0xfff) << 64
      c = custom_c & 0x3fffffffffffffff
      new(a | VERSION | b | VARIANT | c)
    end

    def custom_a
      raise NotImplementedError
    end

    def custom_b
      raise NotImplementedError
    end

    def custom_c
      raise NotImplementedError
    end
  end

  def initialize(bytes)
    super()
    self.value = bytes
  end
end
