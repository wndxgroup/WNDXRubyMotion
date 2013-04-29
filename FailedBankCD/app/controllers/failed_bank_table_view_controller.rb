class FailedBankTableViewController < UITableViewController

  include NSFetchedResultsControllerDelegate

  def viewDidLoad
    super
    error_ptr = Pointer.new(:object)
    @fetch_controller = FailedBankStore.shared.fetched_results_controller
    @fetch_controller.delegate = self
    unless @fetch_controller.performFetch(error_ptr)
      raise "Error when fetching banks: #{error_ptr[0].description}"
    end
  end

  def viewDidUnload
    @fetch_controller = nil
  end

  def viewWillAppear(animated)
    navigationItem.title = 'Failed Banks'
    navigationItem.leftBarButtonItem = editButtonItem
    navigationItem.rightBarButtonItem = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemAdd, target:self, action:'add_bank')
  end

  def add_bank
    FailedBankStore.shared.add_bank do |bank, details|
      bank.name = "Test Bank"
      bank.city = "Test City"
      bank.state = "TestyState"
      details.close_date = NSDate.date
      details.update_date = NSDate.date
      details.zip = 12345
      bank.details = details
    end
    view.reloadData
  end

  def tableView(tableView, numberOfRowsInSection:section)
    @fetch_controller.sections.objectAtIndex(section).numberOfObjects
  end

  def configureCell(cell, atIndexPath:index)
    bank = @fetch_controller.objectAtIndexPath(index)
    cell.textLabel.text = bank.name
    cell.detailTextLabel.text = "#{bank.city}, #{bank.state}"
    return cell
  end

  CellID = 'CellIdentifier'
  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    cell = tableView.dequeueReusableCellWithIdentifier(CellID) || UITableViewCell.alloc.initWithStyle(UITableViewCellStyleSubtitle, reuseIdentifier:CellID)
    configureCell(cell, atIndexPath:indexPath)
  end

  def tableView(tableView, editingStyleForRowAtIndexPath:indexPath)
    UITableViewCellEditingStyleDelete
  end

  def tableView(tableView, commitEditingStyle:editingStyle, forRowAtIndexPath:indexPath)
    FailedBankStore.shared.remove_bank(@fetch_controller.objectAtIndexPath(indexPath))
  end
end
