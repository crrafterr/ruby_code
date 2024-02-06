module Manufacturer
  def set_manufacture(name)
    self.manufacture = name
  end
  
  def get_manufacture
    self.manufacture
  end

  protected
  attr_accessor :manufacture
end