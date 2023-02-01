# frozen_string_literal: true

module Uuid
  # The maximum UUID as defined by {§5.10 of RFC 4122 BIS-01
  # }[https://www.ietf.org/archive/id/draft-ietf-uuidrev-rfc4122bis-01.html#name-max-uuid].
  #
  # This UUID is written as +ffffffff-ffff-ffff-ffff-fffffffffffff+ and is greater than all other UUIDs in comparisons.
  Max = Value.new((2**128) - 1).freeze
end
