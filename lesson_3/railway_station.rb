class Station
  attr_reader :name
  
  def initialize(name)
    @name       = name
    @train_list = []
  end

  def add_train(train)
    @train_list << train
  end

  def show_train_on_station
    return puts "There are no trains at the station" if @train_list.empty? 
    
    puts "List of trains at the station:"
    @train_list.each do |train|
      puts "#{train.number}"
    end
  end
 
  def show_num_trains_by_type
    return puts "There are no trains at the station" if @train_list.empty? 
    passenger = 0
    сargo     = 0

    @train_list.each do |train|
      passenger += 1 if train.type == "passenger"
      сargo     += 1 if train.type == "cargo"
    end
    
    puts "Passanger train in station: #{passenger}"
    puts "Cargo train in station:     #{сargo}"
  end
  
  def delete_train(train)
    return puts "There are no trains at the station" if @train_list.empty?
    @train_list.delete(train)
  end
end

class Route
  attr_reader :route
  
  def initialize(start_station, stop_station)
        @start_station = start_station
        @stop_station  = stop_station
        @route         = [@start_station, @stop_station]
  end

  def add_station_to_route(station)
    @route.insert(-2, station) unless @route.include?(station)
  end
    
  def delete_station_in_route(station)
    @route.delete(station) unless [@start_station, @stop_station].include?(station) 
  end

  def show_route
    i = 1
    puts "List of stations in route:"
    @route.each do |route|
      puts "#{i}: #{route.name}"
      i += 1
    end
  end
end

class Train
  attr_accessor :speed
  attr_reader   :number, :type
  

  def initialize(number, type, num_rail_carr)
    @number        = number
    @type          = type
    @num_rail_carr = num_rail_carr
    @speed         = 0
  end
  
  def stop
    @speed = 0
  end

  def show_num_rail_carr
    puts "The number of carriages at the train is equal to: #{@num_rail_carr}"
  end

  def add_carr
    @num_rail_carr += 1 if @speed == 0
  end

  def delete_carr
    @num_rail_carr -= 1 if @speed == 0
  end

  def assign_route(route)
    @route   = route
    @station = @route.route[0]
  end
  
  def move(direction)
    return puts "Route not assign" unless defined?(@route)
    
    route       = @route.route
    station_num = route.index(@station)
    
    if station_num == 0 && direction == "back"
      puts "The train is at the starting station of the route"
    elsif station_num == route.length - 1 && direction == "forward"
      puts "The train is at the final station of the route"
    else
      @station = route[station_num + 1] if direction == "forward"
      @station = route[station_num - 1] if direction == "back"
    end
  end

  def show_route_info
    return puts "Route not assign" unless defined?(@route)
    
    route       = @route.route
    station_num = route.index(@station)

    if station_num == 0
      prev_st = "Train at the starting station"
      curr_st = @station.name
      next_st = route[station_num + 1].name
    elsif station_num == route.length - 1
      prev_st = route[station_num - 1].name
      curr_st = @station.name
      next_st = "Train at the terminal station"
    else
      prev_st = route[station_num - 1].name
      curr_st = @station.name
      next_st = route[station_num + 1].name
    end

    puts "Previous station: #{prev_st}"
    puts "Current station:  #{curr_st}"  
    puts "Next station:     #{next_st}" 
  end
end