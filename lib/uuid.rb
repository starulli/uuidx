# frozen_string_literal: true

require_relative "uuid/gem_version"
require_relative "uuid/errors"
require_relative "uuid/version4"
require_relative "uuid/version6"
require_relative "uuid/version7"
require_relative "uuid/version8"

# The Uuid module contains a simple API to generate v4, v6, and v7 UUIDs
# without needing to create generators manually.
#
# The simple API is exposed as a set of methods ::v4, ::v6, and ::v7 which
# handle thread-safety and generator creation.
#
#   Uuid.v4 # => "2b54639d-e43e-489f-9c64-30ecdcac3c95"
#   Uuid.v6 # => "1eda9761-9f6f-6414-8c5f-fd61f1239907"
#   Uuid.v7 # => "01863d24-6d1e-78ba-92ee-6e80c79c4e28"
#
# See the Version4, Version6, and Version7 classes for details on how to create
# generators manually.
#
# ===== A Note on Clock Timings
# This library uses the +Process::CLOCK_REALTIME+ clock ID to obtain the current
# time. While the specification allows for implementations to manipulate time
# values, this library does not. Any system-based smearing or drift will appear
# within the timestamp values.
#
# See the Version6 and Version7 documentation for manifestation details.
module Uuid
  # The nil UUID as defined by
  # {§5.10 of RFC 4122 BIS-01}[https://www.ietf.org/archive/id/draft-ietf-uuidrev-rfc4122bis-01.html#name-nil-uuid].
  #
  # This UUID is written as +00000000-0000-0000-0000-000000000000+ and is less than all other UUIDs in comparisons.
  # It does not act as +nil+.
  def self.nil_uuid
    "00000000-0000-0000-0000-000000000000"
  end

  # The maximum UUID as defined by
  # {§5.10 of RFC 4122 BIS-01}[https://www.ietf.org/archive/id/draft-ietf-uuidrev-rfc4122bis-01.html#name-max-uuid].
  #
  # This UUID is written as +ffffffff-ffff-ffff-ffff-ffffffffffff+ and is greater than all other UUIDs in comparisons.
  def self.max_uuid
    "ffffffff-ffff-ffff-ffff-ffffffffffff"
  end

  # Generate a new UUID v4 value using the default generator.
  def self.v4
    @lock4.lock
    r = @uuid4.generate
    @lock4.unlock
    r
  end

  # Generate a new UUID v6 value using the default generator.
  def self.v6
    @lock6.lock
    r = @uuid6.generate
    @lock6.unlock
    r
  end

  # Generate a new UUID v7 value using the default generator.
  def self.v7
    @lock7.lock
    r = @uuid7.generate
    @lock7.unlock
    r
  end

  # Reset the UUID v4 default generator.
  def self.reset_v4!
    @lock4 = Mutex.new
    @uuid4 = Version4.new
  end

  # Reset the UUID v6 default generator.
  def self.reset_v6!
    @lock6 = Mutex.new
    @uuid6 = Version6.new
  end

  # Reset the UUID v7 default generator.
  def self.reset_v7!
    @lock7 = Mutex.new
    @uuid7 = Version7.new
  end

  reset_v4!
  reset_v6!
  reset_v7!

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
