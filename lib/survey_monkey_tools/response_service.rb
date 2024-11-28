# frozen_string_literal: true

module SurveyMonkeyTools
  # class for Survey API
  class ResponseService
    require "json"

    def initialize(http, access_token)
      @http = http
      @access_token = access_token
    end

    def responses(collectors)
      responses = []
      collectors.each do |collector|
        req = Net::HTTP::Get.new("/v3/collectors/#{collector}/responses", headers)
        responses << send_request(req)
      end
      responses
    end

    private

    def headers
      {
        Accept: "application/json",
        Authorization: "Bearer #{@access_token}"
      }
    end

    def send_request(req)
      @http.request(req)
    rescue StandardError => e
      puts e
    end
  end
end
