require_relative 'manufacturer'
require_relative 'instance_counter'
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
      break if number == "11"
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
           "Exit",
         ]

  def get_user_input(message)
    puts "#{message}"
    input = gets.chomp
  end

  def create_station
    name = get_user_input("Enter station name")
    self.stations << Station.new(name)
  end

  def create_train
    number = get_user_input("Enter train name")
    type   = get_user_input("Enter train type (passenger or cargo)")
    if type == "passenger"
      self.trains << PassengerTrain.new(number, type)
    elsif type == "cargo"
      self.trains << CargoTrain.new(number, type)
    else
      puts "Enter passenger or cargo"
    end
  end
  
  def create_route
    route = {}
    name               = get_user_input("Enter route name")
    start_station_name = get_user_input("Enter start station name")
    stop_station_name  = get_user_input("Enter stop station name")
    start_station      = self.stations.select{|station| station.name == start_station_name}
    stop_station       = self.stations.select{|station| station.name == stop_station_name}
    route[name]        = Route.new(start_station, stop_station)
    
    self.routes << route
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

  def assign_route_to_train
    train_number = get_user_input("Enter train number")
    route_name   = get_user_input("Enter route name")
    route_list   = self.routes.select{|r| r.has_key?(route_name)}
    train_list   = self.trains.select{|t| t.number == train_number}
    route        = route_list.first[route_name]
    train        = train_list.first

    train.assign_route(route)
  end

  def add_carriage
    train_number = get_user_input("Enter train number")
    train_list   = self.trains.select{|t| t.number == train_number}
    train        = train_list.first
    
    if train.type == "cargo"
      train.add_carriage(CargoCarriage.new)
    elsif train.type == "pessenger"
      train.add_carriage(PassengerCarriage.new)
    else
      puts "Enter cargo or pessenger"
    end
  end

  def delete_carriage
    train_number = get_user_input("Enter train number")
    train_list   = self.trains.select{|t| t.number == train_number}
    train        = train_list.first
    
    train.delete_carriage
  end

  def move_train
    train_number = get_user_input("Enter train number")
    direction    = get_user_input("Enter direction (forward or back)")
    train_list   = self.trains.select{|t| t.number == train_number}
    train        = train_list.first
    
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
    
    station.first.trains.each{|t| puts t.number}
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
    else
      puts "Enter a number from 1 to 11!"
    end
  end
end

Railway.new.main