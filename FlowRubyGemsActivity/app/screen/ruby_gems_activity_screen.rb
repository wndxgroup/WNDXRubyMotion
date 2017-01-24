class RubyGemsActivityScreen < UI::Screen
  def on_load
    navigation.title = "RubyGems Activity"
    view.add_child(ActivityList.new)
    view.update_layout
  end
end