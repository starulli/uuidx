# frozen_string_literal: true

require_relative "next/version"
require_relative "next/constants"
require_relative "next/v6"
require_relative "next/v7"

module Uuid
  module Next
    class Error < StandardError; end
  end
end
