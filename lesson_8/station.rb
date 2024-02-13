# frozen_string_literal: true

class Station
  include InstanceCounter
  include Validate

  attr_reader :name, :trains

  def self.all
    @all ||= []
  end

  all
  instances

  def initialize(name)
    @name   = name
    @trains = []
    validate!
    self.class.all << self
    register_instance
  end

  def show_trains(&block)
    trains.each(&block)
  end

  def validate!
    raise 'Name can not be empty' if name.empty?
  end

  def add_train(train)
    @trains << train
  end

  def trains_by_type(type)
    trains.select { |train| train.type == type }.size
  end

  def delete_train(train)
    trains.delete(train)
  end
end
