class JournalEntry < NSObject
  attr_accessor :date, :user, :text

  def initialize(date, text, user)
    self.date = date
    self.text = text
    self.user = user
  end
end