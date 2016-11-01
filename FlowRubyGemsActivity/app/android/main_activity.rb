class MainActivity < Android::Support::V7::App::AppCompatActivity
  include RubyGemsActivityApp

  def onCreate(savedInstanceState)
    super
    UI.context = self
    self.start_app
  end
end
