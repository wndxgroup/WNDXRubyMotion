class ActivityList < UI::List
  def initialize
    super
    self.flex = 1
    render_row do
      ActivityRow
    end
    load_activities
  end

  def load_activities
    RubyGemsActivity.just_updated do |gems|
      self.data_source = gems
    end
  end
end
