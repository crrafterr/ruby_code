class Station
  attr_reader :name, :trains
  include InstanceCounter
  include Validate
  
  @@stations = []
  instances

  def self.all
    @@stations
  end

  def initialize(name)
    @name   = name
    @trains = []
    validate!
    @@stations << self
    self.register_instance
  end

  def show_trains
    self.trains.each do |t|
      yield(t)
    end
  end
  
  def validate!
    raise "Name can not be empty" if self.name.empty?
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