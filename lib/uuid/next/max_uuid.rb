# frozen_string_literal: true

require_relative "abstract_uuid"

class Uuid::Next::MaxUuid < Uuid::Next::AbstractUuid
  def initialize
    self.value = 2**128 - 1
  end
end
