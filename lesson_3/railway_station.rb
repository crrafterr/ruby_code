class Station
  attr_reader :name, :trains
  
  def initialize(name)
    @name   = name
    @trains = []
  end

  def add_train(train)
    @trains << train
  end
 
  def trains_by_type(type)
    trains.select{|train| train.type == type}.size
  end
  
  def delete_train(train)
    trains.delete(train)
  end
end

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

class Train
  attr_accessor :speed, :num_rail_carriage, :current_station_index
  attr_reader   :number, :type, :route
  
  def initialize(number, type, num_rail_carriage)
    @number            = number
    @type              = type
    @num_rail_carriage = num_rail_carriage
    @speed             = 0
  end
  
  def stop
    self.speed = 0
  end

  def add_carriage
    self.num_rail_carriage += 1 if speed == 0
  end

  def delete_carriage
    self.num_rail_carriage -= 1 if speed == 0
  end

  def assign_route(route)
    @route = route
    @current_station_index = 0
    current_station.add_train(self)
  end
  
  def go_next_station
    self.current_station_index += 1 if next_station
  end

  def go_previous_station
    self.current_station_index -= 1 if previous_station
  end

  def current_station
    route.route[current_station_index]
  end

  def next_station
    route.route[current_station_index + 1]
  end

  def previous_station
    route.route[current_station_index - 1]
  end
end