class  PassengerCarriage < Carriage
  attr_reader :type
  
  def initialize
    set_type
  end
  
  private
  TYPE = "passenger"
  
  def set_type
    @type = TYPE
  end
end