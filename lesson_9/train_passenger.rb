# frozen_string_literal: true

class PassengerTrain < Train
  validate :number, :presence
  validate :number, :type, String
  validate :number, :format, /\w{3}-?\w{2}/
  validate :type, :presence
  validate :type, :type, String
end
