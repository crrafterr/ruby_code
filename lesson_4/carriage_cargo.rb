class  CargoCarriage < Carriage
  attr_reader :type
  
  def initialize
    set_type
  end
  
  private
  TYPE = "cargo"
  
  def set_type
    @type = TYPE
  end
end