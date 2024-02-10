require_relative 'manufacturer'
require_relative 'instance_counter'
require_relative 'validate'
require_relative 'route'
require_relative 'station'
require_relative 'train'
require_relative 'train_cargo'
require_relative 'train_passenger'
require_relative 'carriage'
require_relative 'carriage_cargo'
require_relative 'carriage_passenger'


class Railway
    
  def initialize
    @stations = []
    @trains = []
    @routes = []
    @menu   = MENU
  end
  
  def main
    loop do
      print_menu(self.menu)
      number = get_user_input("Enter action number")
      break if number == "13"
      action_selection(number)
    end
  end

  private #Все методы ниже должны вызываться из метода main
  
  attr_accessor :stations, :trains, :routes
  attr_reader :menu

  MENU = [ "Create station",
           "Create train",
           "Create route",
           "Edit route",
           "Assign a route",
           "Add carriage",
           "Delete carriage",
           "Move the train along the route",
           "List station",
           "List train on the station",
           "Show carriages",
           "Take the place of carriage",
           "Exit"
         ]

  def get_user_input(message)
    puts "#{message}"
    input = gets.chomp
  end

  def create_station
    begin
      name = get_user_input("Enter station name")
      self.stations << Station.new(name)
      puts "Station with name #{name} was created"
    rescue RuntimeError => e
      puts "#{e}"
      retry
    end
  end

  def create_train
    begin 
      number = get_user_input("Enter train name (format exmple we3-4r qw3ww)")
      type   = get_user_input("Enter train type (passenger or cargo)")
      if type == "passenger"
        self.trains << PassengerTrain.new(number, type)
      elsif type == "cargo"
        self.trains << CargoTrain.new(number, type)
      else
        raise "Type not passenger or cargo" unless type == "passenger" || type == "cargo"
      end
      puts "A #{type} train with number #{number} was created"
    rescue RuntimeError => e
      puts "#{e}"
      retry
    end
  end
  
  def create_route
    begin
      route = {}
      name               = get_user_input("Enter route name")
      start_station_name = get_user_input("Enter start station name")
      stop_station_name  = get_user_input("Enter stop station name")
      start_station      = self.stations.select{|station| station.name == start_station_name}.first
      stop_station       = self.stations.select{|station| station.name == stop_station_name}.first
      route[name]        = Route.new(start_station, stop_station)
    
      self.routes << route
      puts "Route #{name} with start station #{start_station.name} and stop station #{stop_station.name} was created"
    rescue RuntimeError => e
      puts "#{e}"
      puts "Create a station before adding it to your route"
      retry
    end
  end
  
  def edit_route
    name         = get_user_input("Enter route name")
    station_name = get_user_input("Enter station name")
    action       = get_user_input("Enter action (add or delete)")
    route        = self.routes.select{|r| r.has_key?(name)}
    station      = self.stations.select{|s| s.name == station}

    if action == "delete"
      route.first[name].delete_station(station)
    elsif action == "add"
      route.first[name].add_station(station)
    else 
      puts "Enter add or delete"
    end
  end

  def get_train
    train_number = get_user_input("Enter train number")
    train_list   = self.trains.select{|t| t.number == train_number}
    train        = train_list.first
  end

  def assign_route_to_train
    route_name   = get_user_input("Enter route name")
    route_list   = self.routes.select{|r| r.has_key?(route_name)}
    route        = route_list.first[route_name]
    train        = get_train

    train.assign_route(route)
  end

  def add_carriage
    train = get_train
    
    if train.type == "cargo"
      total_volume = get_user_input("Enter the total volume of the cargo carriage")
      train.add_carriage(CargoCarriage.new(total_volume))
    elsif train.type == "passenger"
      total_seats = get_user_input("Enter the number of seats in the carriage")
      train.add_carriage(PassengerCarriage.new(total_seats))
    end
  end
  
  def show_carriages
    i = 0
    train = get_train

    if train.type == "cargo"
      train.shows_carriages {|c| puts "№#{i+=1}, type: #{c.type}, busy volume: #{c.busy_volume}, empty volume: #{c.empty_volume}"}
    elsif train.type == "passenger"
      train.shows_carriages {|c| puts "№#{i+=1}, type: #{c.type}, busy seats: #{c.busy_seats}, empty seats: #{c.empty_seats}"}
    end  
  end

  def delete_carriage
    train = get_train
    train.delete_carriage
  end
  
  def take_place_in_carriages
    train = get_train
    carriage_number = get_user_input("Enter carriage number (total carriages: #{train.carriages.length})").to_i
    if train.type == "cargo"
      volume = get_user_input("Enter the volume").to_i
      train.carriages[carriage_number - 1].take_volume(volume)
    elsif train.type == "passenger"
      train.carriages[carriage_number - 1].take_seat
    end
   end

  def move_train
    direction = get_user_input("Enter direction (forward or back)")
    train     = get_train
    
    if direction == "forward"
      train.go_next_station
    elsif direction == "back"
      train.go_previous_station
    else
      puts "Enter forward or back"
    end
  end

  def show_stations
    self.stations.each {|station| puts "#{station.inspect}"}
  end
  
  def show_trains
    station = get_user_input("Enter station")
    station = self.stations.select{|s| s.name == station}
    
    station.first.show_trains {|t| puts "Train №#{t.number} , type: #{t.type}, number of carrages: #{t.carriages.length}"}
  end

  def print_menu(menu)
    i = 1
    menu.each do |item|
      puts "#{i}. #{item}"
      i += 1
    end
  end

  def action_selection(action_number)
    case action_number
      when "1"
        create_station        
      when "2"
        create_train        
      when "3"
        create_route
      when "4"
        edit_route
      when "5"
        assign_route_to_train
      when "6"
        add_carriage
      when "7"
        delete_carriage
      when "8"
        move_train
      when "9"
        show_stations
      when "10"
        show_trains
      when "11"
        show_carriages
      when "12"
        take_place_in_carriages
    else
      puts "Enter a number from 1 to 12!"
    end
  end
end

Railway.new.main