module Validate
  def self.included(base)
    base.include InstanceMethods
  end

  module InstanceMethods
    def valid?
      validate!
      true
    rescue
      false
    end
  end
end