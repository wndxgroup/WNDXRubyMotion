#
# Copyright (c) 2016 Razeware LLC
# Copyright (c) 2017 The WNDX Group Inc (RubyMotion port)
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
#
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
      label.textColor = "#44758b".to_color
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
        NSForegroundColorAttributeName => "#44758b".to_color,
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
    contentView.backgroundColor = "#0c1f3f".to_color
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