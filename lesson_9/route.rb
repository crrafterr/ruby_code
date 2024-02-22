# frozen_string_literal: true

class Route
  attr_reader :route

  include InstanceCounter
  include Validation

  instances

  validate :route, :type, Array

  def initialize(start_station, stop_station)
    validate!(start_station, stop_station)
    @route = [start_station, stop_station]
    validate!
    register_instance
  end

  def add_station(station)
    route.insert(-2, station)
  end

  def delete_station(station)
    route.delete(station)
  end
end
