# frozen_string_literal: true

module OverflowingGenerator
  def self.custom_a
    (2**49) + 1
  end

  def self.custom_b
    (2**13) + 2
  end

  def self.custom_c
    (2**63) + 3
  end
end