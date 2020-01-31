module GraffitiTracker
  class Report
    attr_accessor :alderman_name, :ward_number, :month, :year, :graffiti_removal_requests

    def initialize(options)
      @alderman_name             = options[:alderman_name]
      @ward_number               = options[:ward_number]
      @month                     = options[:month]
      @year                      = options[:year]
      @graffiti_removal_requests = options[:graffiti_removal_requests]
    end

    def display
      puts "Alderman: #{alderman_name}"
      puts "Ward Number: #{ward_number}"
      puts "Month Covered: #{month}/#{year}"
      puts "Removal Requests: #{graffiti_removal_requests}"
    end
  end
end