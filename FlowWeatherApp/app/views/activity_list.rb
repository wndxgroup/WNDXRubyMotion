class ActivityList< UI::List
  def initialize
    super
    self.flex = 1
    render_row do
      ActivityRow
    end
    load_events
  end

  def load_events
    RubyGemsActivity.just_updated do |activities|
      self.data_source = activities
    end
  end
end