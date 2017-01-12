class User < NSObject
  attr_accessor :userid, :username

  def initialize(id, name)
    self.userid = id
    self.username = name
  end
end