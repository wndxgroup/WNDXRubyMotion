class MessageCell < UICollectionViewCell
  attr_accessor :message_label, :title_label, :status_label
  TITLE_HEIGHT = 30
  def self.font
    @@font ||= Theme::Base.app_font
  end

  def self.cell_size(width, text)
    label_bounds = TextSize.size(text, MessageCell.font, width, Theme::CommonInsets)
    return CGSizeMake(width, label_bounds.size.height + MessageCell::TITLE_HEIGHT)
  end

  def create_message_label
    self.message_label = UILabel.new.tap do |label|
      label.backgroundColor = UIColor.clearColor
      label.numberOfLines = 0
      label.font = MessageCell.font
      label.textColor = UIColor.whiteColor
    end
  end

  def create_title_label
    self.title_label = UILabel.new.tap do |label|
      label.backgroundColor = UIColor.clearColor
      label.font = Theme::Base.app_font(14)
      label.textColor = UIColor.colorWithRed(0.26, green:0.78, blue:0.29, alpha:1.0)
    end
  end

  def create_status_label
    self.status_label = UILabel.new.tap do |label|
      label_color = UIColor.colorWithRed(0.46, green:0.53, blue:0.62, alpha:1.0)
      label.layer.borderColor = label_color.CGColor
      label.layer.borderWidth = 1
      label.backgroundColor = UIColor.clearColor
      label.font = Theme::Base.app_font(8)
      label.textColor = label_color
      label.textAlignment = NSTextAlignmentCenter
      label.text = "NEW MESSAGE"
    end
  end

  def initWithFrame(frame)
    super
    contentView.backgroundColor = UIColor.colorWithRed(0.05, green: 0.12, blue: 0.25, alpha: 1.0)
    contentView.addSubview(create_message_label)
    contentView.addSubview(create_title_label)
    contentView.addSubview(create_status_label)
    self
  end

  def layoutSubviews
    super
    title_label.frame = CGRectMake(Theme::CommonInsets.left, 0, bounds.size.width - Theme::CommonInsets.left - Theme::CommonInsets.right, MessageCell::TITLE_HEIGHT)
    status_label.frame = CGRectMake(bounds.size.width - 80, 4, 70, 18)
    message_frame = CGRectMake(0, CGRectGetMaxY(title_label.frame), bounds.size.width, bounds.size.height - MessageCell::TITLE_HEIGHT)
    message_label.frame = UIEdgeInsetsInsetRect(message_frame, Theme::CommonInsets)
  end
end