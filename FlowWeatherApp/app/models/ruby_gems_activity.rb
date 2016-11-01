class RubyGemsActivity
  API_HOST = 'https://rubygems.org'
  def self.just_updated(&callback)
    Net.get "#{API_HOST}/api/v1/activity/just_updated.json" do |response|
      if response.status == 200
        callback.call(response.body)
      else
        callback.call(nil)
      end
    end
  end
end