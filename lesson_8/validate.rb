# frozen_string_literal: true

module Validate
  def self.included(base)
    base.include InstanceMethods
  end

  module InstanceMethods
    def valid?
      validate!
      true
    rescue StandardError
      false
    end
  end
end
