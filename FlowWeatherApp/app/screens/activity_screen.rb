class ActivityScreen < UI::Screen
  def on_load
    navigation.title = "FlowActivity"
    view.add_child(ActivityList.new)
    view.update_layout
  end
end