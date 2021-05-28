class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    rootViewController = ViewController2.alloc.init
    rootViewController.title = 'CustomBadge'

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = rootViewController
    @window.makeKeyAndVisible

    true
  end
end
