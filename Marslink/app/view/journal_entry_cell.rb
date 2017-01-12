class JournalEntryCell < UICollectionViewCell
  attr_accessor :label

  def self.font
    @@font ||= Theme::Base.app_font
  end

  def self.inset
    @@inset ||= UIEdgeInsetsMake(0, 15, 0, 15)
  end

  def self.cell_size(width, text)
    TextSize.size(text, JournalEntryCell.font, width, JournalEntryCell.inset).size
  end

  def create_label
    self.label = UILabel.new.tap do |label|
      label.backgroundColor = UIColor.clearColor
      label.numberOfLines = 0
      label.font = JournalEntryCell.font
      label.textColor = UIColor.whiteColor
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
    self.label.frame = UIEdgeInsetsInsetRect(bounds, JournalEntryCell.inset)
  end

end