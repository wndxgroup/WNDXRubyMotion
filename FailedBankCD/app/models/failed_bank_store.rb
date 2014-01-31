class FailedBankStore
  def self.shared
    # Our store is a singleton object.
    Dispatch.once { @instance ||= new }
    @instance
  end

  def banks
    @banks ||= begin
      # Fetch all banks from the model, sorting by the creation date.
      request = NSFetchRequest.alloc.init
      request.entity = NSEntityDescription.entityForName('FailedBankInfo', inManagedObjectContext:@context)

      error_ptr = Pointer.new(:object)
      data = @context.executeFetchRequest(request, error:error_ptr)
      if data == nil
        raise "Error when fetching data: #{error_ptr[0].description}"
      end
      data
    end
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
    puts(banks)
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
     # Create the model from the momd file, which is the compiled version of the xcdatamodeld
    model = NSManagedObjectModel.mergedModelFromBundles([NSBundle.mainBundle]).mutableCopy
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

  def save
    error_ptr = Pointer.new(:object)
    unless @context.save(error_ptr)
      raise "Error when saving the model: #{error_ptr[0].description}"
    end
    @banks = nil
  end
end