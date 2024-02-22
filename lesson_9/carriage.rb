# frozen_string_literal: true

class Carriage
  include Manufacturer
  attr_reader :type, :total_place, :busy_place, :empty_place

  def initialize(total_place)
    @total_place = total_place.to_i
    @busy_place = 0
    @empty_place = total_place.to_i
  end
end
