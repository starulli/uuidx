# frozen_string_literal: true

require_relative "uuid/version6"
require_relative "uuid/version7"
require_relative "uuid/version8"
require_relative "uuid/value"

# Note: clock slewing is OS dependant. We use :CLOCK_REALTIME.
# :include: README.md
module Uuid
end
