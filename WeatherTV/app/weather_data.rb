class WeatherData
  attr_accessor :temperature
  attr_accessor :summary
  attr_accessor :icon

  def initialize(current)
    self.summary = current.summary
    self.temperature = current.temperature
    self.icon = current.climacon.chr # Coming in as Fixnum, but it's a char
  end

  def self.load
    # Finds and opens the json file, from the resources dir, which contains the data to be loaded
    path = NSBundle.mainBundle.pathForResource("Locations", ofType:"json")
    BW::JSON.parse(NSData.dataWithContentsOfFile(path))
  end

  def self.locations
    @locations ||= WeatherData.load
  end
end