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