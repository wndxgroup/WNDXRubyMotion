class WeatherData
  def self.shared
    Dispatch.once do
      @instance ||= new
    end
    @instance
  end

  def self.load
    # Finds and opens the json file, from the resources dir, which contains the data to be loaded
    path = NSBundle.mainBundle.pathForResource("Locations", ofType:"json")
    BW::JSON.parse(NSData.dataWithContentsOfFile(path))
  end

  def locations
    @locations ||= WeatherData.load
  end
end