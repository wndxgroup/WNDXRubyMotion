#
# Copyright (c) 2016 Razeware LLC
# Copyright (c) 2017 The WNDX Group Inc (RubyMotion port)
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
class CustomNavigationBar < UINavigationBar

  def initWithFrame(frame)
    super
    @status_on = false
    super.tap do |bar|
      layer.addSublayer(highlight_layer)
      layer.addSublayer(status_indicator)
      bar.addSubview(title_label)
      bar.addSubview(status_label)
      bar.barTintColor = UIColor.blackColor
      self.update_status
    end
  end

  def layoutSubviews
    super
    title_width = 130.0
    border_height = 4.0

    path = UIBezierPath.bezierPath
    path.moveToPoint(CGPointZero)
    path.addLineToPoint(CGPointMake(title_width, 0))
    path.addLineToPoint(CGPointMake(title_width, bounds.size.height - border_height))
    path.addLineToPoint(CGPointMake(bounds.size.width, bounds.size.height - border_height))
    path.addLineToPoint(CGPointMake(bounds.size.width, bounds.size.height))
    path.addLineToPoint(CGPointMake(0, bounds.size.height))
    path.closePath
    highlight_layer.path = path.CGPath

    title_label.frame = CGRectMake(0, 0, title_width, bounds.size.height)
    status_label.frame = CGRectMake(
      bounds.size.width - status_label.bounds.size.width - Theme::CommonInsets.right,
      bounds.size.height - border_height - status_label.bounds.size.height - 6,
      status_label.bounds.size.width,
      status_label.bounds.size.height
    )
    status_indicator.position = CGPointMake(status_label.center.x - 50, status_label.center.y - 1)
  end

  def update_status
    @status_on = !@status_on
    CATransaction.begin
    CATransaction.setValue(KCFBooleanTrue, forKey: KCATransactionDisableActions)
    status_indicator.fillColor = (@status_on ? UIColor.whiteColor : UIColor.blackColor).CGColor
    CATransaction.commit
    Dispatch::Queue.main.after(0.6) { self.update_status }
  end

  def highlight_layer
    @highlight_layer ||= CAShapeLayer.new.tap do |layer|
      layer.fillColor = "#76879D".to_color.CGColor
    end
  end

  def status_indicator
    @status_indicator ||= CAShapeLayer.new.tap do |layer|
      layer.strokeColor = UIColor.whiteColor.CGColor
      layer.lineWidth = 1
      layer.fillColor = UIColor.blackColor.CGColor
      size = 8
      frame = CGRectMake(0, 0, size, size)
      layer.path = UIBezierPath.bezierPathWithRoundedRect(frame, cornerRadius: size/2).CGPath
      layer.frame = frame
    end
  end

  def status_label
    @status_label ||= UILabel.new.tap do |label|
      label.backgroundColor = UIColor.clearColor
      label.text = "RECEIVING"
      label.font = Theme::Base.app_font(13)
      label.textAlignment = NSTextAlignmentCenter
      label.textColor = "#42c84b".to_color
      label.sizeToFit
    end
  end

  def title_label
    @title_label ||= UILabel.new.tap do |label|
      label.backgroundColor = UIColor.clearColor
      label.text = 'MARSLINK'
      label.font = Theme::Base.app_font
      label.textAlignment = NSTextAlignmentCenter
      label.textColor = UIColor.whiteColor
    end
  end
end