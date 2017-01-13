class Pathfinder
  attr_accessor :messages
  attr_accessor :delegate

  def self.shared
    Dispatch.once do
      @instance ||= new
    end
    @instance
  end

  def initialize
    self.messages = []
    load_messages
  end

  def load_messages
    self.messages << lewis_message("Mark, are you receiving me?", -803200)
    self.messages << lewis_message("I think I left behind some ABBA, might help with the drive 😜", -259200)
    delegate.pathfinderDidUpdateMessages(self) unless delegate.nil?
  end

  def connect
    Dispatch::Queue.after(2.3) do
      self.messages << lewis_message("Liftoff in 3...")
      Dispatch::Queue.after(1.0) do
        self.messages << lewis_message("2...")
        Dispatch::Queue.after(1.0) do
          self.messages << lewis_message("1...")
        end
      end
    end
  end

  private
  def lewis_message(text, interval = 0)
    user = User.new(2, "cpt.lewis")
    Message.new(Time.now - interval, text, user)
  end

end