# frozen_string_literal: true

module Uuid
  # The maximum UUID as defined by
  # {§5.10 of RFC 4122 BIS-01}[https://www.ietf.org/archive/id/draft-ietf-uuidrev-rfc4122bis-01.html#name-max-uuid].
  #
  # This UUID is written as +ffffffff-ffff-ffff-ffff-ffffffffffff+ and is greater than all other UUIDs in comparisons.
  def self.max_uuid
    "ffffffff-ffff-ffff-ffff-ffffffffffff"
  end
end
