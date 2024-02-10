class  CargoCarriage < Carriage
  attr_reader :total_volume, :busy_volume, :empty_volume
  def initialize(total_volume)
    @type = :cargo
    @total_volume = total_volume.to_i
    @busy_volume = 0
    @empty_volume = total_volume.to_i
  end
  
  def take_volume(volume)
    if (self.empty_volume - volume) >= 0
      self.busy_volume  += volume
      self.empty_volume -= volume
    end
  end
  
  private
  attr_writer :busy_volume, :empty_volume
end