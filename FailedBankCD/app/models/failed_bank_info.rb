class FailedBankInfo < NSManagedObject
  def self.attributes
    @attributes ||= [
      {:name => 'name', :type => NSStringAttributeType, :default => nil, :optional => false},
      {:name => 'city', :type => NSStringAttributeType, :default => nil, :optional => false},
      {:name => 'state', :type => NSStringAttributeType, :default => nil, :optional => false},
    ]
  end

  def self.relationships
    @relationships ||= [
      {:name => 'details', :destination => 'FailedBankDetails', :inverse => 'info', :optional => true, :transient => false, :indexed => false, :ordered => true, :min => 1, :max => 1, :del => NSCascadeDeleteRule},
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