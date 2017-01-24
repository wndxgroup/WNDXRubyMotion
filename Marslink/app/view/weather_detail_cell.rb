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
class WeatherDetailCell < UICollectionViewCell
  attr_accessor :title_label, :detail_label

  def create_title_label
    self.title_label = UILabel.new.tap do |label|
      label.backgroundColor = UIColor.clearColor
      label.font = Theme::Base.app_font
      label.textColor = "#42c84b".to_color
    end
  end

  def create_detail_label
    self.detail_label = UILabel.new.tap do |label|
      label.backgroundColor = UIColor.clearColor
      label.font = Theme::Base.app_font
      label.textColor = "#42c84b".to_color
      label.textAlignment = NSTextAlignmentRight
    end
  end

  def initWithFrame(frame)
    super
    contentView.addSubview(create_title_label)
    contentView.addSubview(create_detail_label)
    contentView.backgroundColor = "#0c1f3f".to_color
    self
  end

  def layoutSubviews
    super
    inset_bounds = UIEdgeInsetsInsetRect(bounds, Theme::CommonInsets)
    title_label.frame = inset_bounds
    detail_label.frame = inset_bounds
  end
end