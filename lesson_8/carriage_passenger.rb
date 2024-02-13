# frozen_string_literal: true

class PassengerCarriage < Carriage
  def initialize(total_place)
    super
    @type = :passenger
  end

  def take_seat
    return unless empty_place.positive?

    self.busy_place  += 1
    self.empty_place -= 1
  end

  private

  attr_writer :busy_place, :empty_place
end
