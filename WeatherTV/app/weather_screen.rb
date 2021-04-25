class WeatherScreen < PM::Screen
  include BW::KVO

  attr_accessor :weather

  def on_load
    # set up subviews here
    @symbol_label = add UILabel.new, frame: [[ 200, 200 ], [ 200, 200 ]], font: UIFont.fontWithName('Climacons-Font', size: 128.0)
    @temperature_label = add UILabel.new, frame: [[ 200, 400 ], [ 500, 100 ]]
    @description_label = add UILabel.new, frame: [[ 200, 500 ], [ 500, 100 ]]
    observe(self, :weather) do |_, new_value|
      Dispatch::Queue.main.async { update_displayed_weather(new_value) }
    end
    self.get_weather
  end

  def will_appear
    update_displayed_weather(self.weather)
  end

  def location=(location_hash)
    self.title = location_hash[:name]
    @location = CLLocation.alloc.initWithLatitude(location_hash[:lat], longitude: location_hash[:long])
  end

  def get_weather
    request = CZForecastioRequest.newForecastRequest
    request.location = CZWeatherLocation.locationFromLocation(@location)
    request.key = "663717908dcb4a1eb20e7cab8104e52b"
    request.sendWithCompletion -> (data, _) {
      self.weather = WeatherData.new(data.current)
    }
  end

  def update_displayed_weather(new_value)
    puts new_value.inspect
    return if new_value.nil?
    @symbol_label.text = new_value.icon
    @temperature_label.text = new_value.temperature.c.to_s
    @description_label.text = new_value.summary
    self.view.setNeedsLayout
  end
end
