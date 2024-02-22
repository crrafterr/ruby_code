# frozen_string_literal: true

module MenuRouteActions
  def self.included(base)
    base.include InstanceMethods
  end

  module InstanceMethods
    private

    def create_route
      route = {}
      name = get_user_input('Enter route name')
      start_station, stop_station = take_staion_info
      route[name] = Route.new(start_station, stop_station)
      routes << route
      puts "Route #{name} with start station #{start_station.name} and stop station #{stop_station.name} was created"
    rescue RuntimeError => e
      puts e
      retry
    end

    def take_route_info
      name         = get_user_input('Enter route name')
      station_name = get_user_input('Enter station name')
      action       = get_user_input('Enter action (add or delete)')
      route        = routes.select { |r| r.key?(name) }
      station      = stations.select { |s| s.name == station_name }.first
      [name, action, route, station]
    end

    def edit_route
      name, action, route, station = take_route_info
      return route.first[name].delete_station(station) if action == 'delete'

      route.first[name].add_station(station) if action == 'add'
    end
  end
end
