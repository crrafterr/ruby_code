# frozen_string_literal: true

require_relative 'accessor'
require_relative 'manufacturer'
require_relative 'instance_counter'
require_relative 'validation'
require_relative 'route'
require_relative 'station'
require_relative 'train'
require_relative 'train_cargo'
require_relative 'train_passenger'
require_relative 'carriage'
require_relative 'carriage_cargo'
require_relative 'carriage_passenger'
require_relative 'menu_train_actions'
require_relative 'menu_station_actions'
require_relative 'menu_route_actions'

class Menu
  include MenuTrainActions
  include MenuStationActions
  include MenuRouteActions
  include Accessor

  def initialize
    @stations = []
    @trains = []
    @routes = []
    @menu = MENU
  end

  def main
    loop do
      print_menu(menu)
      number = get_user_input('Enter action number')
      break if number == '13'

      action_selection(number)
    end
  end

  private # Все методы ниже должны вызываться из метода main

  attr_accessor_with_history :stations, :trains, :routes
  attr_reader :menu

  MENU = ['Create station', 'Create train', 'Create route', 'Edit route', 'Assign a route', 'Add carriage',
          'Delete carriage', 'Move the train along the route', 'List station', 'List train on the station',
          'Show carriages', 'Take the place of carriage', 'Exit'].freeze

  ACTION_NUMBER = { '1' => 'create_station', '2' => 'create_train', '3' => 'create_route', '4' => 'edit_route',
                    '5' => 'assign_route_to_train', '6' => 'add_carriage', '7' => 'delete_carriage',
                    '8' => 'move_train', '9' => 'show_stations', '10' => 'show_trains_in_station',
                    '11' => 'show_carriages', '12' => 'take_place_in_carriages' }.freeze

  def get_user_input(message)
    puts message
    gets.chomp
  end

  def print_menu(menu)
    i = 1
    menu.each do |item|
      puts "#{i}. #{item}"
      i += 1
    end
  end

  def action_selection(number)
    method(ACTION_NUMBER[number]).call
  end
end

Menu.new.main
