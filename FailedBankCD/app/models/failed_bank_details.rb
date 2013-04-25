class FailedBankDetails < NSManagedObject
  def self.attributes
    @attributes ||= [
      {:name => 'zip', :type => NSInteger32AttributeType, :default => 0, :optional => false},
      {:name => 'close_date', :type => NSDateAttributeType, :default => nil, :optional => false},
      {:name => 'update_date', :type => NSDateAttributeType, :default => nil, :optional => false},
    ]
  end

  def self.relationships
    @relationships ||= [
      {:name => 'info', :destination => 'FailedBankInfo', :inverse => 'details', :optional => true, :transient => false, :indexed => false, :ordered => true, :min => 1, :max => 1, :del => NSCascadeDeleteRule},
    ]
  end

  def self.entity
    @entity ||= begin
      # Create the entity for our managed object class
      entity = NSEntityDescription.alloc.init
      entity.name = name
      entity.managedObjectClassName = name
      entity
    end
  end

end