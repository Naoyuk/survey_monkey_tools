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
    desc "version", "show survey_monkey_tools version"
    def version
      puts "survey_monkey_tools #{VERSION}"
    end

    desc "copy", "copy new surveys from surveys of last year"
    def copy
      puts "done copy"
    end

    desc "get", "get surveys"
    def get
      access_token = ENV["ACCESS_TOKEN"]

      uri = URI.parse(BASE_URI)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      headers = { Accept: "application/json", Authorization: "Bearer #{access_token}" }

      req = Net::HTTP::Get.new("/v3/surveys", headers)
      res = http.request(req)
      data = res.body

      puts data
    end
  end
end
