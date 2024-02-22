# frozen_string_literal: true

module MenuTrainActions
  def self.included(base)
    base.include InstanceMethods
  end

  module InstanceMethods
    private

    def create_train
      number = get_user_input('Enter train name (format exmple we3-4r qw3ww)')
      type   = get_user_input('Enter train type (passenger or cargo)')
      return trains << PassengerTrain.new(number, type) if type == 'passenger'
      return trains << CargoTrain.new(number, type) if type == 'cargo'
      return raise 'Type not passenger or cargo' unless %w[passenger cargo].include?(type)

      puts "A #{type} train with number #{number} was created"
    rescue RuntimeError => e
      puts e
      retry
    end

    def take_train_info
      train_number = get_user_input('Enter train number')
      train_list   = trains.select { |t| t.number == train_number }
      train_list.first
    end

    def assign_route_to_train
      route_name   = get_user_input('Enter route name')
      route_list   = routes.select { |r| r.key?(route_name) }
      route        = route_list.first[route_name]
      train        = take_train_info
      train.assign_route(route)
    end

    def add_carriage
      train = take_train_info
      total_place = get_user_input('Enter the total place of the carriage')
      train.add_carriage(CargoCarriage.new(total_place)) if train.type == 'cargo'
      train.add_carriage(PassengerCarriage.new(total_place)) if train.type == 'passenger'
    end

    def show_carriage_info(train)
      i = 0
      train.shows_carriages.each { |c| puts "№#{i += 1} type:#{c.type} busy:#{c.busy_place} empty:#{c.empty_place}" }
    end

    def show_carriages
      train = take_train_info
      show_carriage_info(train)
    end

    def delete_carriage
      train = take_train_info
      train.delete_carriage
    end

    def add_place(train, carriage_number)
      place = get_user_input('Enter the volume').to_i if train.type == 'cargo'
      train.carriages[carriage_number - 1].take_volume(place) if train.type == 'cargo'
      train.carriages[carriage_number - 1].take_seat if train.type == 'passenger'
    end

    def take_place_in_carriages
      train = take_train_info
      carriage_number = get_user_input("Enter carriage number (#{train.carriages.length})").to_i
      add_place(train, carriage_number)
    end

    def move_train
      direction = get_user_input('Enter direction (forward or back)')
      train     = take_train_info
      return train.go_next_station if direction == 'forward'

      train.go_previous_station if direction == 'back'
    end
  end
end
