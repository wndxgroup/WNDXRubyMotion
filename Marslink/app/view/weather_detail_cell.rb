class WeatherDetailCell < UICollectionViewCell
  attr_accessor :title_label, :detail_label

  def create_title_label
    self.title_label = UILabel.new.tap do |label|
      label.backgroundColor = UIColor.clearColor
      label.font = Theme::Base.app_font
      label.textColor = UIColor.colorWithRed(0.26, green:0.78, blue:0.29, alpha:1.0)
    end
  end

  def create_detail_label
    self.detail_label = UILabel.new.tap do |label|
      label.backgroundColor = UIColor.clearColor
      label.font = Theme::Base.app_font
      label.textColor = UIColor.colorWithRed(0.26, green:0.78, blue:0.29, alpha:1.0)
      label.textAlignment = NSTextAlignmentRight
    end
  end

  def initWithFrame(frame)
    super
    contentView.addSubview(create_title_label)
    contentView.addSubview(create_detail_label)
    contentView.backgroundColor = UIColor.colorWithRed(0.05, green: 0.12, blue: 0.25, alpha: 1.0)
    self
  end

  def layoutSubviews
    super
    inset_bounds = UIEdgeInsetsInsetRect(bounds, Theme::CommonInsets)
    title_label.frame = inset_bounds
    detail_label.frame = inset_bounds
  end
end