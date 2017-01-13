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