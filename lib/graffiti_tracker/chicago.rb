require_relative './removal_request.rb'
require_relative './alderman.rb'
require_relative './report.rb'
require 'http'

module GraffitiTracker
  class Chicago

    DEFAULT_CHICAGO_API_ENDPOINT = "https://data.cityofchicago.org/resource/htai-wnw4.json"
    DEFAULT_WARD_API_ENDPOINT = "https://data.cityofchicago.org/resource/hec5-y4x5.json"

    def self.search_alderman(search_name)
      chicago_api_endpoint = DEFAULT_CHICAGO_API_ENDPOINT
      chicago_api_endpoint += "?$where=alderman%20like%20%27%25#{search_name.gsub(/ +/, '%20')}%25%27"

      response = HTTP.get(chicago_api_endpoint)
      case response.code
      when 200
        search_results = response.parse
        if search_results.length > 1
          puts "Which alderman are you looking for?"
          search_results.each_with_index do |search_result, index|
            puts "#{index + 1}.#{search_result["alderman"]}"
          end
          option = gets.chomp.to_i - 1
        elsif search_results.length == 1
          option = 0
        else
          puts "Could not find alderman #{search_name}"
        end
        Alderman.new(name: search_results[option]["alderman"], ward_number: search_results[option]["ward"]) if option
      when 400
        puts "Bad Request."
      end
    end

    def self.search_removal_requests(ward_number, month, year, options = {})
      ward_api_endpoint = DEFAULT_WARD_API_ENDPOINT
      ward_api_endpoint += "?ward=#{ward_number}"
      ward_api_endpoint += "&creation_date=#{year}-#{month}-05T00:00:00.000"
      ward_api_endpoint += "&where_is_the_graffiti_located_=#{options[:graffiti_location]}" if options[:graffiti_location]

      response = HTTP.get(ward_api_endpoint)
      case response.code
      when 200
        results_array = []
        removal_requests = response.parse
        removal_requests.each do |removal_request|
          results_array << RemovalRequest.new(
                                              creation_date: removal_request["creation_date"],
                                              completion_date: removal_request["completion_date"],
                                              street_address: removal_request["street_address"]
                                              )
        end
        results_array
      when 400
        puts "Bad Request."
      end
    end

    def self.generate_report(search_name, month, year, options = {})
      if alderman = search_alderman(search_name)
        removal_requests = search_removal_requests(alderman.ward_number, month, year, options)
        Report.new(
                    alderman_name: alderman.name,
                    ward_number: alderman.ward_number,
                    month: month,
                    year: year,
                    graffiti_removal_requests: removal_requests.count
                  )
      end
    end
  end
end

# p GraffitiTracker::Chicago.search_removal_requests(47, 05, 2018)
# p GraffitiTracker::Chicago.search_alderman("Moore")
report = GraffitiTracker::Chicago.generate_report("Moore", 12, 2017)
report.display