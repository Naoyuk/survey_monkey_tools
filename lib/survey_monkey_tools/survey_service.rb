# frozen_string_literal: true

module SurveyMonkeyTools
  # class for Survey API
  class SurveyService
    def initialize(http, access_token)
      @http = http
      @access_token = access_token
    end

    def response(endpoint)
      req = Net::HTTP::Get.new("/v3#{endpoint}", headers)
      send_request(req)
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
