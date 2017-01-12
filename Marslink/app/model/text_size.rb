class TextSize
  CacheEntry = Struct.new(:text, :font, :width, :insets)
  @@cache = {}

  def self.cache
    @@cache
  end

  def self.size(text, font, width, insets = UIEdgeInsetsZero)
    key = CacheEntry.new(text, font, width, insets).hash
    return cache[key] if cache[key]

    constrained_size = CGSizeMake(width - insets.left - insets.right, CGFLOAT_MAX)
    attributes = { NSFontAttributeName => font }
    options = NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin
    bounds = text.boundingRectWithSize(constrained_size, options: options, attributes: attributes, context: nil)
    bounds.size.width = width
    bounds.size.height = (bounds.size.height + insets.top + insets.bottom).ceil
    cache[key] = bounds
    bounds
  end
end
