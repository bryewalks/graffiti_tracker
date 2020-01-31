require_relative './removal_request.rb'
require_relative './alderman.rb'
require_relative './report.rb'
require 'http'

module GraffitiTracker
  class Chicago
    attr_accessor :month, :year, :search_name, :report, :graffiti_location

    def initialize(options)
      @search_name       = options[:search_name]
      @month             = options[:month]
      @year              = options[:year]
      @graffiti_location = options[:graffiti_location]
    end

    def search_alderman
      alderman_name = search_name.gsub(/ +/, '%20')
      response = HTTP.get("https://data.cityofchicago.org/resource/htai-wnw4.json?$where=alderman%20like%20%27%25#{alderman_name}%25%27")
      case response.code
      when 200
        searched = response.parse
        option = 0
        if searched.length == 0
          puts "Could not find alderman with last name #{search_name}"
        else
          if searched.length > 1
            puts "Which alderman are you looking for?"
            searched.each_with_index do |resp, index|
              puts "#{index + 1}.#{resp["alderman"]}"
            end
            option = gets.chomp.to_i - 1
          end
          Alderman.new(
                        name: searched[option]["alderman"],
                        ward_number: searched[option]["ward"]
                      )
        end
      when 400
        puts "Bad Request."
      end
    end

    def search_requests(ward_number)      
      response = HTTP.get("https://data.cityofchicago.org/resource/hec5-y4x5.json?ward=#{ward_number}#{creation_query}#{graffiti_location_query}")
      case response.code
      when 200
        results_array = []
        removal_requests = response.parse
        removal_requests.each do |removal_request|
          results_array << RemovalRequest.new(date: removal_request["date"])
        end
        results_array
      when 400
        puts "Bad Request."
      end
    end

    def build_report
      alderman = search_alderman
      if alderman
        requests = search_requests(alderman.ward_number)
        @report = Report.new(
                    alderman_name: alderman.name,
                    ward_number: alderman.ward_number,
                    month: month,
                    year: year,
                    graffiti_removal_requests: requests.count)
      end
    end

    def display_report
      if report
        report.display
      else
        puts "No report generated"
      end
    end

    private

    def creation_query
      if month && year
        "&creation_date=#{year}-#{month}-05T00:00:00.000"
      end
    end

    def graffiti_location_query
      if graffiti_location
        "&where_is_the_graffiti_located_=#{graffiti_location}"
      end
    end

  end
end

gt = GraffitiTracker::Chicago.new(search_name: "Moore", month: 05, year: 2012, graffiti_location: "Alley")
gt.build_report
gt.display_report
