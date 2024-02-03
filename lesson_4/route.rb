class Route
  attr_reader :route
  
  def initialize(start_station, stop_station)
    @route = [start_station, stop_station]
  end

  def add_station(station)
    route.insert(-2, station)
  end
    
  def delete_station(station)
    route.delete(station) 
  end
end