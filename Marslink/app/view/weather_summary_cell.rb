class WeatherSummaryCell < UICollectionViewCell
  attr_accessor :expand_label, :title_label
  TITLE_HEIGHT = 30
  def self.font
    @@font ||= Theme::Base.app_font
  end

  def self.cell_size(width, text)
    label_bounds = TextSize.size(text, MessageCell.font, width, Theme::CommonInsets)
    return CGSizeMake(width, label_bounds.size.height + MessageCell::TITLE_HEIGHT)
  end

  def create_expand_label
    self.expand_label = UILabel.new.tap do |label|
      label.backgroundColor = UIColor.clearColor
      label.font = Theme::Base.app_font(30)
      label.textColor = UIColor.colorWithRed(0.26, green:0.78, blue:0.29, alpha:1.0)
      label.textAlignment = NSTextAlignmentCenter
      label.text = ">>"
      label.sizeToFit
    end
  end

  def create_title_label
    self.title_label = UILabel.new.tap do |label|
      label.backgroundColor = UIColor.clearColor
      label.numberOfLines = 0
      paragraph_style = NSMutableParagraphStyle.new
      paragraph_style.paragraphSpacing = 4
      subtitle_attributes = {
        NSFontAttributeName => Theme::Base.app_font(14),
        NSForegroundColorAttributeName => UIColor.colorWithRed(0.26, green:0.78, blue:0.29, alpha:1.0),
        NSParagraphStyleAttributeName => paragraph_style
      }
      title_attributes = {
        NSFontAttributeName => Theme::Base.app_font(24),
        NSForegroundColorAttributeName => UIColor.whiteColor
      }
      attributed_text = NSMutableAttributedString.alloc.initWithString("LATEST\n", attributes: subtitle_attributes)
      attributed_text.appendAttributedString(NSAttributedString.alloc.initWithString("WEATHER", attributes: title_attributes))
      label.attributedText = attributed_text
      label.sizeToFit
    end
  end

  def initWithFrame(frame)
    super
    contentView.backgroundColor = UIColor.colorWithRed(0.05, green: 0.12, blue: 0.25, alpha: 1.0)
    contentView.addSubview(create_expand_label)
    contentView.addSubview(create_title_label)
    self
  end

  def expanded=(is_expanded)
    self.expand_label.transform = is_expanded ? CGAffineTransformMakeRotation(Math::PI / 2) : CGAffineTransformIdentity
  end

  def layoutSubviews
    super
    insets = Theme::CommonInsets
    title_label.frame = CGRectMake(insets.left, 0, title_label.bounds.size.width, bounds.size.height)
    expand_label.center = CGPointMake(bounds.size.width - expand_label.bounds.size.width/2 - insets.right, bounds.size.height/2)
  end
end