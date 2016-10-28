class AppDelegate < PM::Delegate
  def on_load(app, options)
    locations = []
    WeatherData.shared.locations.each do |location|
      locations << WeatherScreen.new.tap do |screen|
        screen.title = location[:name]
      end
    end
    open_tab_bar *locations
  end
end