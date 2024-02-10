class  PassengerCarriage < Carriage
  attr_reader :total_seats, :busy_seats, :empty_seats
  def initialize(total_seats)
    @type = :passenger
    @total_seats = total_seats.to_i
    @busy_seats = 0
    @empty_seats = total_seats.to_i
  end

  def take_seat
    if self.empty_seats > 0
      self.busy_seats  += 1
      self.empty_seats -= 1
    end
  end
  
  private
  attr_writer :busy_seats, :empty_seats
end