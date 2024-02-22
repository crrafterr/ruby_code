# frozen_string_literal: true

class Station
  include InstanceCounter
  include Validation

  attr_reader :name, :trains

  def self.all
    @all ||= []
  end

  all
  instances
  validate :name, :presence
  validate :name, :type, String
  validate :name, :format, /[a-zA-Z]/
  validate :trains, :type, Array

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
