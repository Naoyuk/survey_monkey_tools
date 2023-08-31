# frozen_string_literal: true

require "survey_monkey_tools"
require "json"
require "thor"
require "uri"
require "net/http"
require "dotenv"
require "debug"
Dotenv.load

module SurveyMonkeyTools
  # class for CLI command execution
  class CLI < Thor
    desc "version", "shows survey_monkey_tools version"
    def version
      puts "survey_monkey_tools #{VERSION}"
    end

    desc "surveys", "gets surveys"
    def surveys
      puts response(END_POINTS[:surveys]).body
    end

    desc "create_survey", "creates a survey"
    def create_survey(params)
      response = request(END_POINTS[:surveys], params: params)
      message = response.code == "201" ? "Survey is successfully created" : "Error has occured"
      puts "#{message}\nStatus: #{response.code}\n#{response.body}"
    rescue StandardError => e
      puts e
    end

    desc "folders", "gets folders"
    def folders
      puts response(END_POINTS[:folders]).body
    end

    desc "copy", "copys new surveys from surveys of last year"
    def copy
      puts "done copy"
    end

    desc "create_folder", "creates a folder"
    def create_folder(title)
      response = request(END_POINTS[:folders], params: { title: title })
      message = response.code == "201" ? "Folder is successfully created" : "Error has occured"
      puts "#{message}\nStatus: #{response.code}\n#{response.body}"
    rescue StandardError => e
      puts e
    end

    private

    def access_token
      ENV["ACCESS_TOKEN"]
    end

    def http
      uri = URI.parse(BASE_URI)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http
    end

    def response(endpoint)
      headers = { Accept: "application/json", Authorization: "Bearer #{access_token}" }
      req = Net::HTTP::Get.new("/v3#{endpoint}", headers)

      begin
        http.request(req)
      rescue StandardError => e
        puts e
      end
    end

    def request(endpoint, body)
      headers = { Accept: "application/json", Authorization: "Bearer #{access_token}" }
      req = Net::HTTP::Post.new("/v3#{endpoint}", headers)
      req.content_type = "application/json"
      req.body = body[:params].to_json

      begin
        http.request(req)
      rescue StandardError => e
        puts e
      end
    end
  end
end
