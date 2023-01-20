# frozen_string_literal: true

require_relative "nil_uuid"
require_relative "max_uuid"

module Uuid::Next
  NIL_UUID = NilUuid.new.freeze
  MAX_UUID = MaxUuid.new.freeze
end
