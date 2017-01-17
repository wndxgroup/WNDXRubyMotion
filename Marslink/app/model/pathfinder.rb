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