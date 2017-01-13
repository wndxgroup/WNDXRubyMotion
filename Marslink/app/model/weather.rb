class Weather < NSObject
  include DiffableProtocol

  attr_accessor :temperature,
                :high,
                :low,
                :date,
                :sunrise,
                :sunset,
                :condition

  def initialize(temp, high, low, date, sunrise, sunset, condition = nil)
    self.temperature = temp
    self.high = high
    self.low = low
    self.date = date
    self.sunrise = sunrise
    self.sunset = sunset
    self.condition = condition
  end
end