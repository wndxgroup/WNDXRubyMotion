module NSFetchedResultsControllerDelegate

  def controllerWillChangeContent(controller)
    self.tableView.beginUpdates
  end

  def controller(controller, didChangeObject:object, atIndexPath:path, forChangeType:type, newIndexPath:new_path)
    tableView = self.tableView
    case type
      when NSFetchedResultsChangeInsert
        tableView.insertRowsAtIndexPaths([new_path], withRowAnimation:UITableViewRowAnimationFade)
      when NSFetchedResultsChangeDelete
        tableView.deleteRowsAtIndexPaths([path], withRowAnimation:UITableViewRowAnimationFade)
      when NSFetchedResultsChangeUpdate
        configureCell(tableView.cellForRowAtIndexPath(path), atIndexPath:path)
      when NSFetchedResultsChangeMove
        tableView.deleteRowsAtIndexPaths([path], withRowAnimation:UITableViewRowAnimationFade)
        tableView.insertRowsAtIndexPaths([new_path], withRowAnimation:UITableViewRowAnimationFade)
    end
  end

  def controller(controller, sectionIndexTitleForSectionName:sectionName)
  end

  def controller(controller, didChangeSection:section, atIndex:index, forChangeType:type)
    case type
      when NSFetchedResultsChangeInsert
        self.tableView.insertSections( NSIndexSet.indexSetWithIndex(index), withRowAnimation:UITableViewRowAnimationFade)
      when NSFetchedResultsChangeDelete
        self.tableView.deleteSections( NSIndexSet.indexSetWithIndex(index), withRowAnimation:UITableViewRowAnimationFade)
    end
  end

  def controllerDidChangeContent(controller)
    self.tableView.endUpdates
  end
end