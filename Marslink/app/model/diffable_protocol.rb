# Required for IGListDiffable
module DiffableProtocol
  def diffIdentifier
    self
  end

  def isEqualToDiffableObject(object)
    isEqual(object)
  end
end