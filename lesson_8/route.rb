# frozen_string_literal: true

class Route
  attr_reader :route

  include InstanceCounter
  include Validate

  instances

  def initialize(start_station, stop_station)
    validate!(start_station, stop_station)
    @route = [start_station, stop_station]
    register_instance
  end

  def validate!(start_station, stop_station)
    raise 'The start station does not exist.' if start_station.class != Station
    raise 'The stop station does not exist.' if stop_station.class != Station
  end

  def valid?
    validate!(route.first, route.last)
    true
  rescue StandardError
    false
  end

  def add_station(station)
    route.insert(-2, station)
  end

  def delete_station(station)
    route.delete(station)
  end
end
