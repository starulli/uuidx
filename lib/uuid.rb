# frozen_string_literal: true

require_relative "uuid/gem_version"
require_relative "uuid/errors"
require_relative "uuid/value"
require_relative "uuid/max"
require_relative "uuid/nil"
require_relative "uuid/version6"
require_relative "uuid/version7"
require_relative "uuid/version8"

# NOTE: clock slewing is OS dependent. We use Process::CLOCK_REALTIME.
# NOTE: clock resolution can be verified for v6 and v7.
# :include: README.md
module Uuid
end
