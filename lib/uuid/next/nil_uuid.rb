# frozen_string_literal: true

require_relative "abstract_uuid"

class Uuid::Next::NilUuid < Uuid::Next::AbstractUuid
  def initialize
    self.value = 0
  end
end
