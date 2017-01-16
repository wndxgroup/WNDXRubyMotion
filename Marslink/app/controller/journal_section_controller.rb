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
class JournalSectionController < IGListSectionController
  attr_accessor :entry

  def sol_formatter
    @sol_formatter ||= SolFormatter.new
  end

  def init
    super
    self.inset = UIEdgeInsetsMake(0,0,15,0)
    self
  end

  def numberOfItems
    2
  end

  def sizeForItemAtIndex(index)
    return CGRectZero unless collectionContext && entry
    width = collectionContext.containerSize.width
    if index == 0
      CGSizeMake(width, 30)
    else
      JournalEntryCell.cell_size(width, self.entry.text)
    end
  end

  def cellForItemAtIndex(index)
    cell_class = index == 0 ? JournalEntryDateCell.self : JournalEntryCell.self
    cell = collectionContext.dequeueReusableCellOfClass(cell_class, forSectionController: self, atIndex: index)
    if cell.instance_of? JournalEntryDateCell
      cell.label.text = "SOL #{sol_formatter.sols(self.entry.date)}"
    elsif cell.instance_of? JournalEntryCell
      cell.label.text = self.entry.text
    end
    cell
  end

  def didUpdateToObject(object)
    self.entry = object
  end

  def didSelectItemAtIndex(_)
  end
end