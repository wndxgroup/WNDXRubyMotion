class FailedBankStore
  def self.shared
    # Our store is a singleton object.
    @shared ||= FailedBankStore.new
  end


  def fetched_results_controller
    fetch_request = NSFetchRequest.alloc.init
    fetch_request.entity = NSEntityDescription.entityForName('FailedBankInfo', inManagedObjectContext:@context)
    sort = NSSortDescriptor.alloc.initWithKey("details.close_date", ascending: false)
    fetch_request.sortDescriptors = [sort]
    fetch_request.fetchBatchSize = 20

    NSFetchedResultsController.alloc.initWithFetchRequest(fetch_request,
                                                          managedObjectContext:@context,
                                                          sectionNameKeyPath:nil,
                                                          cacheName:"Root")
  end

  def add_bank
    # Yield a blank, newly created bank entity, then save the model.
    yield NSEntityDescription.insertNewObjectForEntityForName('FailedBankInfo', inManagedObjectContext:@context),
        NSEntityDescription.insertNewObjectForEntityForName('FailedBankDetails', inManagedObjectContext:@context)
    save
  end

  def remove_bank(bank)
    # Delete the given entity, then save the model.
    @context.deleteObject(bank)
    save
  end

  # The purpose of the load, is to pull in data from an external source, and load it into your CoreData store. It can
  # be invoked from the REPL
  def self.load
    # Finds and opens the json file, from the resources dir, which contains the data to be loaded
    path = NSBundle.mainBundle.pathForResource("Banks", ofType:"json")
    banks = BW::JSON.parse(NSData.dataWithContentsOfFile(path))
    banks.each do |bank|
      FailedBankStore.shared.add_bank do |info, details|
        info.name = bank['name']
        info.city = bank['city']
        info.state = bank['state']
        details.close_date = NSDate.dateWithNaturalLanguageString(bank['closeDate'])
        details.update_date = NSDate.date
        details.zip = bank['zip']
        info.details = details
      end
    end
  end

  private

  def initialize
    # Create the model programmatically. Our model has multiple entities, and the data will be stored in a SQLite database, inside the application's Documents folder.
    model ||= NSManagedObjectModel.alloc.init.tap do |m|
      m.entities = [FailedBankInfo, FailedBankDetails].collect {|c| c.entity}
      m.entities.each {|entity| set_entity_properties(entity,m)}
    end
    store = NSPersistentStoreCoordinator.alloc.initWithManagedObjectModel(model)
    store_url = NSURL.fileURLWithPath(File.join(NSHomeDirectory(), 'Documents', 'banks.sqlite'))
    error_ptr = Pointer.new(:object)
    unless store.addPersistentStoreWithType(NSSQLiteStoreType, configuration:nil, URL:store_url, options:nil, error:error_ptr)
      raise "Can't add persistent SQLite store: #{error_ptr[0].description}"
    end

    context = NSManagedObjectContext.alloc.init
    context.persistentStoreCoordinator = store
    @context = context
  end

  def set_entity_properties(entity, model)
    # set up attributes
    managed_object_class = Object.const_get(entity.managedObjectClassName)
    entities = model.entitiesByName

    attributes = managed_object_class.attributes.collect do |attr|
      property = NSAttributeDescription.alloc.init
      property.name = attr[:name]
      property.attributeType = attr[:type]
      property.defaultValue = attr[:default]
      property.optional = attr[:optional]
      property
    end
    # set up relationships
    relationships = managed_object_class.relationships.map do |rel|
      relation = NSRelationshipDescription.alloc.init
      relation.name = rel[:name]
      relation.destinationEntity = entities[rel[:destination]]
      relation.inverseRelationship = entities[rel[:inverse]]
      relation.optional = rel[:optional] || false
      relation.transient = rel[:transient] || false
      relation.indexed = rel[:indexed] || false
      relation.ordered = rel[:ordered] || false
      relation.minCount = rel[:min] || 1
      relation.maxCount = rel[:max] || 1 # NSIntegerMax
      relation.deleteRule = rel[:del] || NSNullifyDeleteRule # NSNoActionDeleteRule NSNullifyDeleteRule NSCascadeDeleteRule
      relation
    end
    # assign properties
    entity.properties = attributes + relationships
  end

  def save
    error_ptr = Pointer.new(:object)
    unless @context.save(error_ptr)
      raise "Error when saving the model: #{error_ptr[0].description}"
    end
  end
end