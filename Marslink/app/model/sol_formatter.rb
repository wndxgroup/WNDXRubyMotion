class SolFormatter
  attr_accessor :landing_date

  def initialize(landing_date = Time.now - 31725960)
    self.landing_date = landing_date
  end

  def sols(from_date)
    martian_day = 1477 * 60 # 24h37m
    seconds = from_date.timeIntervalSinceDate(self.landing_date)
    (seconds / martian_day).round
  end
end