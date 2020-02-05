module GraffitiTracker
  class RemovalRequest
    attr_accessor :creation_date, :completion_date, :street_address

    def initialize(options)
      @creation_date = options[:creation_date]
      @completion_date = options[:completion_date]
      @street_address = options[:street_address]
    end

    def completed? 
      true if completion_date
    end
  end
end