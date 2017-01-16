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
class MessageSectionController < IGListSectionController
  attr_accessor :message

  def init
    super
    self.inset = UIEdgeInsetsMake(0,0,15,0)
    self
  end

  def numberOfItems
    1
  end

  def sizeForItemAtIndex(index)
    return CGRectZero unless collectionContext && message
    MessageCell.cell_size(collectionContext.containerSize.width, self.message.text)
  end

  def cellForItemAtIndex(index)
    cell = collectionContext.dequeueReusableCellOfClass(MessageCell.self, forSectionController: self, atIndex: index)
    cell.message_label.text = self.message.text
    cell.title_label.text = self.message.user.name.upcase
    cell
  end

  def didUpdateToObject(object)
    self.message = object
  end

  def didSelectItemAtIndex(_)
  end
end