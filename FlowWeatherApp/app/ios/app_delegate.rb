class AppDelegate
  include FlowWeatherShared
  attr_accessor :window

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    self.app_setup
  end
end
