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
class TextSize
  CacheEntry = Struct.new(:text, :font, :width, :insets)
  @@cache = {}

  def self.cache
    @@cache
  end

  def self.size(text, font, width, insets = UIEdgeInsetsZero)
    key = CacheEntry.new(text, font, width, insets).hash
    return cache[key] if cache[key]

    constrained_size = CGSizeMake(width - insets.left - insets.right, CGFLOAT_MAX)
    attributes = { NSFontAttributeName => font }
    options = NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin
    bounds = text.boundingRectWithSize(constrained_size, options: options, attributes: attributes, context: nil)
    bounds.size.width = width
    bounds.size.height = (bounds.size.height + insets.top + insets.bottom).ceil
    cache[key] = bounds
    bounds
  end
end