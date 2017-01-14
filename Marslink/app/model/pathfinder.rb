class Pathfinder
  include BW::KVO
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
    observe(self, :messages) do |_, _|
      delegate.pathfinderDidUpdateMessages(self)
    end
  end

  def load_messages
    add_message(lewis_message("Mark, are you receiving me?", -803200))
    add_message(lewis_message("I think I left behind some ABBA, might help with the drive 😜", -259200))
  end

  def add_message(message)
    self.willChangeValueForKey(:messages)
    self.messages << message
    self.didChangeValueForKey(:messages)
  end

  def connect
    Dispatch::Queue.main.after(2.3) do
      add_message(lewis_message("Liftoff in 3..."))
      Dispatch::Queue.main.after(1.0) do
        add_message(lewis_message("2..."))
        Dispatch::Queue.main.after(1.0) do
          add_message(lewis_message("1..."))
        end
      end
    end
  end

  private
  def lewis_message(text, interval = 0)
    user = User.new(2, "cpt.lewis")
    Message.new(Time.now + interval, text, user)
  end
end