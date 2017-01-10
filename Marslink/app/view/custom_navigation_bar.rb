class CustomNavigationBar < UINavigationBar

  def initWithFrame(frame)
    super.tap do |bar|
      layer.addSublayer(highlight_layer)
      bar.addSubview(title_label)
      bar.barTintColor = UIColor.blackColor
    end
  end

  def layoutSubviews
    super
    title_width = 130.0
    border_height = 4.0

    path = UIBezierPath.bezierPath
    path.moveToPoint(CGPointZero)
    path.addLineToPoint(CGPointMake(title_width, 0))
    path.addLineToPoint(CGPointMake(title_width, bounds.size.height - border_height))
    path.addLineToPoint(CGPointMake(bounds.size.width, bounds.size.height - border_height))
    path.addLineToPoint(CGPointMake(bounds.size.width, bounds.size.height))
    path.addLineToPoint(CGPointMake(0, bounds.size.height))
    path.closePath
    highlight_layer.path = path.CGPath

    title_label.frame = CGRectMake(0, 0, title_width, bounds.size.height)
    # statusLabel.frame = CGRect(
    #   x: bounds.width - statusLabel.bounds.width - CommonInsets.right,
    #   y: bounds.height - borderHeight - statusLabel.bounds.height - 6,
    #   width: statusLabel.bounds.width,
    #   height: statusLabel.bounds.height
    # )
    # statusIndicator.position = CGPoint(x: statusLabel.center.x - 50, y: statusLabel.center.y - 1)
  end

  def highlight_layer
    @highlight_layer ||= CAShapeLayer.new.tap do |layer|
      layer.fillColor = UIColor.colorWithRed(0.46, green:0.53, blue:0.62, alpha:1.0).CGColor
    end
  end

  def title_label
    @title_label ||= UILabel.new.tap do |label|
      label.backgroundColor = UIColor.clearColor
      label.text = 'MARSLINK'
      label.font = Theme::Base.app_font
      label.textAlignment = NSTextAlignmentCenter
      label.textColor = UIColor.whiteColor
    end
  end
end