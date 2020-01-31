module GraffitiTracker
  class RemovalRequest
    attr_accessor :date

    def initialize(options)
      @date = options[:date]
    end
  end
end