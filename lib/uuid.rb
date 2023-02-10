# frozen_string_literal: true

require_relative "uuid/gem_version"
require_relative "uuid/errors"
require_relative "uuid/value"
require_relative "uuid/max"
require_relative "uuid/nil"
require_relative "uuid/version4"
require_relative "uuid/version6"
require_relative "uuid/version7"
require_relative "uuid/version8"

# NOTE: clock slewing is OS dependent. We use Process::CLOCK_REALTIME.
# NOTE: clock resolution can be verified for v6 and v7.
# :include: README.md
module Uuid
  # :nodoc:
  def self.format(value)
    b = +value.to_s(16).rjust(32, "0")
    b.insert(8, "-")
    b.insert(13, "-")
    b.insert(18, "-")
    b.insert(23, "-")
    b.freeze
  end
end
