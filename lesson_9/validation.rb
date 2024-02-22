# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    attr_reader :validations

    def validate(attribute, type, *args)
      @validations ||= []
      @validations << [attribute, type, args]
    end

    protected

    def validate_presence(attribute)
      raise 'Name can not be nil' if attribute.nil?
      raise 'Name not string' unless attribute.instance_of?(String)
      raise 'Name can not be empty string' if attribute.empty?
    end

    def validate_format(attribute, args)
      raise "#{attribute} format not correct" if attribute !~ args.first
    end

    def validate_type(attribute, args)
      raise "#{attribute} class is not #{args.first}" if attribute.class != args.first
    end
  end

  module InstanceMethods
    def validate!
      self.class.validations.each do |validation|
        attribute = instance_variable_get("@#{validation.first}")
        self.class.send :validate_presence, attribute if validation[1] == :presence
        self.class.send :validate_format, attribute, validation.last if validation[1] == :format
        self.class.send :validate_type, attribute, validation.last if validation[1] == :type
      end
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end
  end
end
