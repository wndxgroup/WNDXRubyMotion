class WeatherSectionController < IGListSectionController
  attr_accessor :weather, :expanded

  def init
    super
    self.expanded = false
    self.inset = UIEdgeInsetsMake(0,0,15,0)
    self
  end

  def numberOfItems
    self.expanded ? 5 : 1
  end

  def sizeForItemAtIndex(index)
    return CGRectZero unless collectionContext
    width = collectionContext.containerSize.width
    if index == 0
      CGSizeMake(width, 70)
    else
      CGSizeMake(width, 40)
    end
  end

  def cellForItemAtIndex(index)
    cell_class = index == 0 ? WeatherSummaryCell.self : WeatherDetailCell.self
    cell = collectionContext.dequeueReusableCellOfClass(cell_class, forSectionController: self, atIndex: index)
    if cell.instance_of? WeatherSummaryCell
      cell.expanded = self.expanded
    elsif cell.instance_of? WeatherDetailCell
      case index
      when 1
        title = "SUNRISE"
        detail = weather.sunrise
      when 2
        title = "SUNSET"
        detail = weather.sunset
      when 3
        title = "HIGH"
        detail = "#{weather.high} C"
      when 4
        title = "LOW"
        detail = "#{weather.low} C"
      else
        title = "n/a"
        detail = "n/a"
      end
      cell.detail_label.text = detail
      cell.title_label.text = title
    end
    cell
  end

  def didUpdateToObject(object)
    self.weather = object
  end

  def didSelectItemAtIndex(_)
    self.expanded = !self.expanded
    collectionContext.reloadSectionController(self)
  end
end