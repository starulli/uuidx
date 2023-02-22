# frozen_string_literal: true

module Uuidx
  # Top-level error for all Uuidx errors.
  class Error < StandardError
  end

  # Raised when the clock resolution is insufficient for a UUID Version.
  class ClockResolutionError < Error
  end
end
