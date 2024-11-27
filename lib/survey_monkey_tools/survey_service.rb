# frozen_string_literal: true

module SurveyMonkeyTools
  # class for Survey API
  class SurveyService
    def initialize(http, access_token)
      @http = http
      @access_token = access_token
    end

    def response(endpoint)
      headers = { Accept: "application/json", Authorization: "Bearer #{@access_token}" }
      req = Net::HTTP::Get.new("/v3#{endpoint}", headers)

      begin
        @http.request(req)
      rescue StandardError => e
        puts e
      end
    end

    def post(endpoint, body)
      headers = { Accept: "application/json", Authorization: "Bearer #{@access_token}" }
      req = Net::HTTP::Post.new("/v3#{endpoint}", headers)
      req.content_type = "application/json"
      req.body = body[:params].to_json

      begin
        @http.request(req)
      rescue StandardError => e
        puts e
      end
    end

    def patch(endpoint, body)
      headers = { Accept: "application/json", Authorization: "Bearer #{@access_token}" }
      req = Net::HTTP::Patch.new("/v3#{endpoint}", headers)
      req.content_type = "application/json"
      req.body = body[:params].to_json

      begin
        @http.request(req)
      rescue StandardError => e
        puts e
      end
    end
  end
end
