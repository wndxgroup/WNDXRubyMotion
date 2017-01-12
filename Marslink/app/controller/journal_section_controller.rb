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