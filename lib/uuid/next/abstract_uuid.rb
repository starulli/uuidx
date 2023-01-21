# frozen_string_literal: true

class Uuid::Next::AbstractUuid
  def to_s
    b = +value.to_s(16).rjust(32, "0")
    b.insert(8, "-")
    b.insert(13, "-")
    b.insert(18, "-")
    b.insert(23, "-")
    b.freeze
  end

  protected

  attr_accessor :value
end
