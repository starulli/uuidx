require_relative "../lib/uuid"

class ConstantGenerator < Uuid::Version8
  def custom_a
    1
  end

  def custom_b
    2
  end

  def custom_c
    3
  end
end

g = ConstantGenerator.new
100_000.times { g.generate }
