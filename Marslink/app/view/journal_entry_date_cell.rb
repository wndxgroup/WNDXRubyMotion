class JournalEntryDateCell < UICollectionViewCell
  attr_accessor :label

  def create_label
    self.label = UILabel.new.tap do |label|
      label.backgroundColor = UIColor.clearColor
      label.font = Theme::Base.app_font(14)
      label.textColor = UIColor.colorWithRed(0.26, green:0.78, blue:0.29, alpha:1.0)
    end
  end

  def initWithFrame(frame)
    super
    contentView.backgroundColor = UIColor.colorWithRed(0.05, green: 0.12, blue: 0.25, alpha: 1.0)
    contentView.addSubview(create_label)
    self
  end

  def layoutSubviews
    super
    padding = Theme::CommonInsets
    self.label.frame = UIEdgeInsetsInsetRect(bounds, UIEdgeInsetsMake(0, padding.left, 0, padding.right))
  end
end