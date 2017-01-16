#
# Copyright (c) 2016 Razeware LLC
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
#
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
    pathfinder.delegate = self
    pathfinder.connect
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

  def pathfinderDidUpdateMessages(_)
    @adapter.performUpdatesAnimated(true, completion: nil)
  end
end