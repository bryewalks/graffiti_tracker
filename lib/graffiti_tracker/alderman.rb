module GraffitiTracker
  class Alderman
    attr_accessor :name, :ward_number

    def initialize(options)
      @name        = options[:name]
      @ward_number = options[:ward_number]
    end
  end
end