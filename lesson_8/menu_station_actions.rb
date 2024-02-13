# frozen_string_literal: true

module MenuStationActions
  def self.included(base)
    base.include InstanceMethods
  end

  module InstanceMethods
    private

    def create_station
      name = get_user_input('Enter station name')
      stations << Station.new(name)
      puts "Station with name #{name} was created"
    rescue RuntimeError => e
      puts e
      retry
    end

    def take_staion_info
      start_station_name = get_user_input('Enter start station name')
      stop_station_name  = get_user_input('Enter stop station name')
      start_station      = stations.select { |station| station.name == start_station_name }.first
      stop_station       = stations.select { |station| station.name == stop_station_name }.first
      [start_station, stop_station]
    end

    def show_stations
      stations.each { |station| puts station.name }
    end

    def show_trains_in_station
      station = get_user_input('Enter station')
      station = stations.select { |s| s.name == station }
      station.first.show_trains { |t| puts "Train №#{t.number}, type:#{t.type}, carrages:#{t.carriages.length}" }
    end
  end
end
