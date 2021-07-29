module CGBadgeable

  DEFAULT_DIAMETER = 30

  def addCGBadge(count)
    count_label = create_count_label(count)
    badge = create_badge(count_label)

    @badge_circle_view = UIView.new.tap do |view|
      view.layer.addSublayer(badge)
      view.addSubview(count_label)
    end

    addSubview(@badge_circle_view)
  end

  def count_text=(new_count)
    @badge_circle_view.removeFromSuperview
    addCGBadge(new_count)
  end

  private

  def badge_frame(text_width)
    badge_width = [DEFAULT_DIAMETER, text_width + DEFAULT_DIAMETER/3].max
    CGRectMake(image.size.width - badge_width/2, -DEFAULT_DIAMETER/2, badge_width, DEFAULT_DIAMETER)
  end

  def create_badge(count_label)
    oval_path = UIBezierPath.bezierPathWithRoundedRect(badge_frame(count_label.intrinsicContentSize.width), cornerRadius: DEFAULT_DIAMETER / 2)
    badge = CAShapeLayer.layer
    badge.path = oval_path.CGPath
    badge.fillColor = UIColor.systemBlueColor.CGColor
    badge
  end

  def create_count_label(count_text)
    UILabel.new.tap do |label|
      label.textAlignment = NSTextAlignmentCenter
      label.textColor = UIColor.whiteColor
      label.backgroundColor = UIColor.clearColor
      label.text = count_text
      label.frame = label_frame(label.intrinsicContentSize.width)
    end
  end

  def label_frame(label_width)
    CGRectMake(image.size.width - label_width/2, -DEFAULT_DIAMETER/2, label_width, DEFAULT_DIAMETER)
  end

end
class UIImageView
  include CGBadgeable
end