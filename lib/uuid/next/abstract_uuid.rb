# frozen_string_literal: true

class Uuid::Next::AbstractUuid
  def to_s
    format("%<a>08x-%<b>04x-%<c>04x-%<d>04x-%<e>012x",
           a: (value >> 96) & 0xffffffff,
           b: (value >> 80) & 0xffff,
           c: (value >> 64) & 0xffff,
           d: (value >> 48) & 0xffff,
           e: value & 0xffffffffffff)
  end

  protected

  attr_accessor :value
end
