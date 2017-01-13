class WxScanner
  def self.current_weather
    Weather.new(6, 13, -69, Time.now, "05:42", "17:58")
  end
end
