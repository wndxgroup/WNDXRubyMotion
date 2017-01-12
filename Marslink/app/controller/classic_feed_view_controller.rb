class ClassicFeedViewController < UIViewController

  def loader
    JournalEntryLoader.shared
  end

  def sol_formatter
    @sol_formatter ||= SolFormatter.new
  end

  def create_collection_view
    layout = UICollectionViewFlowLayout.new.tap do |layout|
      layout.minimumLineSpacing = 0
      layout.minimumInteritemSpacing = 0
      layout.sectionInset = UIEdgeInsetsMake(0, 0, 15, 0)
    end
    @collection_view = UICollectionView.alloc.initWithFrame(CGRectZero, collectionViewLayout: layout).tap do |view|
      view.backgroundColor = UIColor.blackColor
      view.alwaysBounceVertical = true
    end
  end

  def viewDidLoad
    super
    create_collection_view
    @collection_view.registerClass(JournalEntryCell.self, forCellWithReuseIdentifier: JournalEntryCell.name)
    @collection_view.registerClass(JournalEntryDateCell.self, forCellWithReuseIdentifier: JournalEntryDateCell.name)
    @collection_view.dataSource = self
    @collection_view.delegate = self
    view.addSubview(@collection_view)
    loader.load_latest
  end
  
  def viewDidLayoutSubviews
    super
    @collection_view.frame = view.bounds
  end

  def numberOfSectionsInCollectionView(_)
    loader.entries.count
  end

  def collectionView(_, numberOfItemsInSection: _)
    2
  end

  def collectionView(collection_view, cellForItemAtIndexPath: index_path)
    identifier = index_path.item == 0 ? JournalEntryDateCell.name : JournalEntryCell.name
    cell = collection_view.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: index_path)
    entry = loader.entries[index_path.section]
    if cell.instance_of? JournalEntryDateCell
      cell.label.text = "SOL (#{sol_formatter.sols(entry.date)})"
    elsif cell.instance_of? JournalEntryCell
      cell.label.text = entry.text
    end
    cell
  end

  def collectionView(collection_view, layout: layout, sizeForItemAtIndexPath: index_path)
    width = collection_view.bounds.size.width
    if index_path.item == 0
      CGSizeMake(width, 30)
    else
      entry = loader.entries[index_path.section]
      JournalEntryCell.cell_size(width, entry.text)
    end
  end
end
