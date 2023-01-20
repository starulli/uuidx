# frozen_string_literal: true

class Uuid::Next::AbstractUuid
  def to_s = format(
    "%08x-%04x-%04x-%04x-%012x",
    value >> 96 & 0xffffffff,
    value >> 80 & 0xffff,
    value >> 64 & 0xffff,
    value >> 48 & 0xffff,
    value & 0xffffffffffff,
  )

  protected

  attr_accessor :value
end
