#
# Copyright (c) 2016 Razeware LLC
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