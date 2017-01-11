module Theme
  CommonInsets = UIEdgeInsetsMake(8, 15, 8, 15)

  class Base
    def self.app_font(font_size = 18.0)
      UIFont.fontWithName('OCRAStd', size:font_size)
    end
  end
end