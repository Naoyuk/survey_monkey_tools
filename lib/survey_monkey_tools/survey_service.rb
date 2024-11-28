# frozen_string_literal: true

module SurveyMonkeyTools
  # class for Survey API
  class SurveyService
    require "json"

    def initialize(http, access_token)
      @http = http
      @access_token = access_token
    end

    def surveys(endpoint)
      req = Net::HTTP::Get.new("/v3#{endpoint}", headers)
      send_request(req)
    end

    def collectors(surveys)
      surveys_array = JSON.parse(surveys.body)["data"]
      collectors = []
      surveys_array.each do |survey|
        req = Net::HTTP::Get.new("/v3/surveys/#{survey["id"]}/collectors", headers)
        collectors << JSON.parse(send_request(req).body)["data"].map { |item| item["id"] }
      end
      collectors.flatten
    end

    def puts_surveys(endpoint)
      surveys = surveys(endpoint)
      parsed_json = JSON.parse(surveys.body)
      result_array = []
      parsed_json["data"].map do |item|
        result_array << { id: item["id"], title: item["title"], num_surveys: item["num_surveys"] }
      end

      result_array
    end

    def post(endpoint, body)
      req = Net::HTTP::Post.new("/v3#{endpoint}", headers)
      req.content_type = "application/json"
      req.body = body[:params].to_json
      send_request(req)
    end

    def patch(endpoint, body)
      req = Net::HTTP::Patch.new("/v3#{endpoint}", headers)
      req.content_type = "application/json"
      req.body = body[:params].to_json
      send_request(req)
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
