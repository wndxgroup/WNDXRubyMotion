class FailedBankTableViewController < UITableViewController
  def viewDidLoad
    view.dataSource = view.delegate = self
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
    FailedBankStore.shared.banks.size
  end

  CellID = 'CellIdentifier'
  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    cell = tableView.dequeueReusableCellWithIdentifier(CellID) || UITableViewCell.alloc.initWithStyle(UITableViewCellStyleSubtitle, reuseIdentifier:CellID)
    bank = FailedBankStore.shared.banks[indexPath.row]
    cell.textLabel.text = bank.name
    cell.detailTextLabel.text = "#{bank.city}, #{bank.state}"
    cell
  end

  def tableView(tableView, editingStyleForRowAtIndexPath:indexPath)
    UITableViewCellEditingStyleDelete
  end

  def tableView(tableView, commitEditingStyle:editingStyle, forRowAtIndexPath:indexPath)
    bank = FailedBankStore.shared.banks[indexPath.row]
    FailedBankStore.shared.remove_bank(bank)
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation:UITableViewRowAnimationFade)
  end
end
