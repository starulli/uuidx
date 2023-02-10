# frozen_string_literal: true

class OverflowingGeneratorDefinition
  def custom_a
    (2**49) + 1
  end

  def custom_b
    (2**13) + 2
  end

  def custom_c
    (2**63) + 3
  end
end
