# frozen_string_literal: true

require "survey_monkey_tools"
require "thor"
require "uri"
require "net/http"
require "dotenv"
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
      puts response("/surveys").body
    end

    desc "folders", "gets folders"
    def folders
      puts response("/survey_folders").body
    end

    desc "copy", "copys new surveys from surveys of last year"
    def copy
      puts "done copy"
    end

    desc "create_folder", "creates a folder"
    def create_folder
    end

    desc "response", "Returns the response for the endpoint passed as an argument"
    def response(endpoint)
      headers = { Accept: "application/json", Authorization: "Bearer #{access_token}" }
      req = Net::HTTP::Get.new("/v3#{endpoint}", headers)

      begin
        uri = URI.parse(BASE_URI)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.request(req)
      rescue StandardError => e
        puts e
      end
    end

    private

    def access_token
      ENV["ACCESS_TOKEN"]
    end
  end
end
