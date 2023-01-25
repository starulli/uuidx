# frozen_string_literal: true

module Uuid
  # The nil UUID as defined by {§5.10 of RFC 4122 BIS-00
  # }[https://www.ietf.org/archive/id/draft-ietf-uuidrev-rfc4122bis-00.html#name-nil-uuid].
  #
  # This UUID is written as +00000000-0000-0000-0000-0000000000000+ and is less than all other UUIDs in comparisons.
  # It does not act as +nil+.
  Nil = Value.new(0).freeze
end
