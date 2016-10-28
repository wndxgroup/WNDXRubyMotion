class AppDelegate < PM::Delegate
  def on_load(app, options)
    tabs = WeatherData.locations.inject([]) do |tabs, location|
      tabs << WeatherScreen.new.tap do |screen|
        screen.location = location
      end
    end
    open_tab_bar *tabs
  end
end