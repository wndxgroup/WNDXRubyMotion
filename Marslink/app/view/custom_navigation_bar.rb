class CustomNavigationBar < UINavigationBar

  def initWithFrame(frame)
    super.tap do |bar|
      bar.addSubview(title_label)
      bar.barTintColor = UIColor.blackColor
    end
  end

  def layoutSubviews
    super
    title_width = 130.0
    # border_height = 4.0

    # let path = UIBezierPath()
    # path.move(to: .zero)
    # path.addLine(to: CGPoint(x: titleWidth, y: 0))
    # path.addLine(to: CGPoint(x: titleWidth, y: bounds.height - borderHeight))
    # path.addLine(to: CGPoint(x: bounds.width, y: bounds.height - borderHeight))
    # path.addLine(to: CGPoint(x: bounds.width, y: bounds.height))
    # path.addLine(to: CGPoint(x: 0, y: bounds.height))
    # path.close()
    # highlightLayer.path = path.cgPath

    title_label.frame = CGRectMake(0, 0, title_width, bounds.size.height)
    # statusLabel.frame = CGRect(
    #   x: bounds.width - statusLabel.bounds.width - CommonInsets.right,
    #   y: bounds.height - borderHeight - statusLabel.bounds.height - 6,
    #   width: statusLabel.bounds.width,
    #   height: statusLabel.bounds.height
    # )
    # statusIndicator.position = CGPoint(x: statusLabel.center.x - 50, y: statusLabel.center.y - 1)
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