class FeedViewController < UIViewController
  def loader
    JournalEntryLoader.shared
  end

  def pathfinder
    Pathfinder.shared
  end

  def create_collection_view
    @collection_view = IGListCollectionView.alloc.initWithFrame(CGRectZero, collectionViewLayout: UICollectionViewFlowLayout.new).tap do |view|
      view.backgroundColor = UIColor.blackColor
    end
  end

  def create_adapter
    @adapter = IGListAdapter.alloc.initWithUpdater(IGListAdapterUpdater.new, viewController: self, workingRangeSize: 0)
  end

  def viewDidLoad
    super
    loader.load_latest
    create_collection_view
    create_adapter
    view.addSubview(@collection_view)
    @adapter.collectionView = @collection_view
    @adapter.dataSource = self
  end

  def viewDidLayoutSubviews
    super
    @collection_view.frame = view.bounds
  end

  def objectsForListAdapter(_)
    (loader.entries +
        pathfinder.messages +
          [WxScanner.current_weather]
    ).sort_by! {|entry| entry.date}.reverse
  end

  def listAdapter(_, sectionControllerForObject: object)
    if object.is_a?(Message)
      MessageSectionController.new
    elsif object.is_a?(Weather)
      WeatherSectionController.new
    else
      JournalSectionController.new
    end
  end

  def emptyViewForListAdapter(_)
    nil
  end
end