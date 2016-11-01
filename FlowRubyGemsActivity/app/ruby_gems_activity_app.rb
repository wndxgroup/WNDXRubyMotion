module RubyGemsActivityApp
  def start_app
    activity_screen = RubyGemsActivityScreen.new
    navigation = UI::Navigation.new(activity_screen)
    flow_app = UI::Application.new(navigation, self)
    flow_app.start
  end
end