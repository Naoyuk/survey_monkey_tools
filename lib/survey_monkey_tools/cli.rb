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
      puts response(END_POINTS[:surveys], :get).body
    end

    desc "post_survey", "creates a survey"
    option :params, type: :hash
    def post_survey(params)
      res = response(END_POINTS[:surveys], :post, params: params)
      message = res.code == "201" ? "Survey is successfully created" : "Error has occured"
      puts "#{message}\nStatus: #{res.code}\n#{res.body}"
    rescue StandardError => e
      puts e
    end

    desc "patch_survey", "updates a survey"
    option :id
    option :params, type: :hash
    def patch_survey(id, params)
      res = response("#{END_POINTS[:surveys]}/#{id}", :patch, params: params)
      message = res.code == "200" ? "Survey is successfully updated" : "Error has occured"
      puts "#{message}\nStatus: #{res.code}\n#{res.body}"
    rescue StandardError => e
      puts e
    end

    desc "folders", "gets folders"
    def folders
      puts response(END_POINTS[:folders], :get).body
    end

    desc "copy", "copys new surveys from surveys of last year"
    def copy
      puts "done copy"
    end

    desc "post_folder", "creates a folder"
    option :params, type: :hash
    def post_folder(params)
      res = response(END_POINTS[:folders], :post, params: params)
      message = res.code == "201" ? "Folder is successfully created" : "Error has occured"
      puts "#{message}\nStatus: #{res.code}\n#{res.body}"
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

    def response(endpoint, method, params=nil)
      headers = { Accept: "application/json", Authorization: "Bearer #{access_token}" }

      case method
        when :get
          req = Net::HTTP::Get.new("/v3#{endpoint}", headers)
        when :post, :patch
          req = Net::HTTP.const_get(method.capitalize).new("/v3#{endpoint}", headers)
          req.content_type = "application/json"
          req.body = JSON.parse(params[:params]).to_json
          # req.body = params[:params].to_json
        # Uncomment and add other HTTP methods as needed
        # when :put
        # when :delete
        else
          raise ArgumentError, "Unsupported HTTP method: #{method}"
        end

      send_request(req)
    end

    def send_request(req)
      begin
        http.request(req)
      rescue StandardError => e
        puts e
      end
    end
  end
end
