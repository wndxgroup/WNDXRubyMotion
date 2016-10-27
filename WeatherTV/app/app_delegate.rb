class AppDelegate < PM::Delegate
  def on_load(app, options)
    locations = []
    %w(Calgary Lethbridge).each do |city|
      locations << WeatherScreen.new.tap do |screen|
        screen.title = city
      end
    end
    open_tab_bar *locations
  end
end