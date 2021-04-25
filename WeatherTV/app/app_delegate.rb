class AppDelegate < PM::Delegate
  def on_load(app, options)
    # Load the weather data locations
    tabs = WeatherData.locations.inject([]) do |tabs, location|
      # For each location, create a new weather screen and save
      tabs << WeatherScreen.new.tap do |screen|
        screen.location = location
      end
    end
    # Add all the weather screens to the tab bar
    open_tab_bar *tabs
  end
end