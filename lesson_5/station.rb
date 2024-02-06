class Station
  attr_reader :name, :trains
  include InstanceCounter
  
  @@stations = []
  instances

  def self.all
    @@stations
  end

  def initialize(name)
    @name   = name
    @trains = []
    @@stations << self
    self.register_instance
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