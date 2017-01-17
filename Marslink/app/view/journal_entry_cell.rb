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
    contentView.backgroundColor = "#0c1f3f".to_color
    contentView.addSubview(create_label)
    self
  end

  def layoutSubviews
    super
    self.label.frame = UIEdgeInsetsInsetRect(bounds, JournalEntryCell.inset)
  end

end