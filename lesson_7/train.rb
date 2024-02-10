class Train
  attr_reader   :number, :type, :carriages
  include Manufacturer
  include InstanceCounter
  include Validate
  
  @@trains = []
  instances

  def self.find(number)
    @@trains.select{|t| t.number == number}.first
  end

  def initialize(number, type)
    @number   = number
    @type     = type
    validate!
    @carriages = []
    @speed    = 0
    @@trains << self
    self.register_instance
  end
  
  def shows_carriages
    self.carriages.each do |t|
      yield(t)
    end
  end

  def validate!
    raise "Number can not be empty" if self.number.empty?
    raise "The number does not match the format" if self.number !~ /\w{3}-?\w{2}/
  end
  
  def add_carriage(carriage)
    self.carriages << carriage if speed == 0
  end

  def delete_carriage
    self.carriages.pop if speed == 0
  end

  def assign_route(route)
    @route = route
    @current_station_index = 0
    current_station.add_train(self)
  end
  
  def go_next_station
    current_station.delete_train(self)
    self.current_station_index += 1 if next_station
    current_station.add_train(self)
  end

  def go_previous_station
    current_station.delete_train(self)
    self.current_station_index -= 1 if previous_station
    current_station.add_train(self)
  end

  protected # Методы ниже не являются интерфейсами класса, но должны быть доступны подклассам
  
  attr_accessor :speed, :current_station_index
  attr_reader   :route
  attr_writer   :carriages
  
  def stop
    self.speed = 0
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