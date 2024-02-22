# frozen_string_literal: true

class CargoCarriage < Carriage
  def initialize(total_place)
    super
    @type = :cargo
  end

  def take_volume(place)
    return unless (empty_place - place) >= 0

    self.busy_place  += place
    self.empty_place -= place
  end

  private

  attr_writer :busy_place, :empty_place
end
