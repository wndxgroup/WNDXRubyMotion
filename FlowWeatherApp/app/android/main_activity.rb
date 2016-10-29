class MainActivity < Android::Support::V7::App::AppCompatActivity
  include FlowWeatherShared

  def onCreate(savedInstanceState)
    super
    UI.context = self
    self.app_setup
  end
end
