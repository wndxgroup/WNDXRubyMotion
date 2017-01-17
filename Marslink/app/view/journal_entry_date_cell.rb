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
class JournalEntryDateCell < UICollectionViewCell
  attr_accessor :label

  def create_label
    self.label = UILabel.new.tap do |label|
      label.backgroundColor = UIColor.clearColor
      label.font = Theme::Base.app_font(14)
      label.textColor = "#42c84b".to_color
    end
  end

  def initWithFrame(frame)
    super
    contentView.backgroundColor = "#0c1f3f".to_color
    contentView.addSubview(create_label)
    self
  end

  def layoutSubviews
    super
    padding = Theme::CommonInsets
    self.label.frame = UIEdgeInsetsInsetRect(bounds, UIEdgeInsetsMake(0, padding.left, 0, padding.right))
  end
end