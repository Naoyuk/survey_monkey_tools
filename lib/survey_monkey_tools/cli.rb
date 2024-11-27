# frozen_string_literal: true

require "survey_monkey_tools"
require "json"
require "thor"
require "uri"
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
      puts survey_service.response(END_POINTS[:surveys]).body
    end

    desc "post_survey", "creates a survey"
    def post_survey(params)
      response = survey_service.post(END_POINTS[:surveys], params: params)
      message = response.code == "201" ? "Survey is successfully created" : "Error has occured"
      puts "#{message}\nStatus: #{response.code}\n#{response.body}"
    rescue StandardError => e
      puts e
    end

    desc "patch_survey", "updates a survey"
    def patch_survey(id, params)
      response = survey_service.patch("#{END_POINTS[:surveys]}/#{id}", params: params)
      message = response.code == "200" ? "Survey is successfully updated" : "Error has occured"
      puts "#{message}\nStatus: #{response.code}\n#{response.body}"
    rescue StandardError => e
      puts e
    end

    desc "folders", "gets folders"
    def folders
      puts survey_service.response(END_POINTS[:folders]).body
    end

    desc "copy", "copys new surveys from surveys of last year"
    def copy
      puts "done copy"
    end

    desc "post_folder", "creates a folder"
    def post_folder(title)
      response = survey_service.post(END_POINTS[:folders], params: { title: title })
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

    def survey_service
      SurveyService.new(http, access_token)
    end
  end
end
