class AppDelegate
  include RubyGemsActivityApp

  attr_accessor :window

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    self.start_app
  end
end
