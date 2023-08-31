# frozen_string_literal: true

require "survey_monkey_tools"
require "webmock/rspec"
require "json"

RSpec.describe SurveyMonkeyTools do
  describe "#version" do
    it "output version strings" do
      survey_monkey_tools = SurveyMonkeyTools::CLI.new
      expect do
        survey_monkey_tools.version
      end.to output("survey_monkey_tools #{SurveyMonkeyTools::VERSION}\n").to_stdout
    end
  end

  describe "#surveys" do
    before do
      filepath = "fixtures/surveymonkey/get_surveys_response.json"
      endpoint = SurveyMonkeyTools::END_POINTS[:surveys]
      build_stub(filepath, :get, endpoint)
    end

    it "returns a correct stdout" do
      survey_monkey_tools = SurveyMonkeyTools::CLI.new

      expect { survey_monkey_tools.surveys }.to output(@body).to_stdout
    end
  end

  describe "#folders" do
    before do
      filepath = "fixtures/surveymonkey/get_folders_response.json"
      endpoint = SurveyMonkeyTools::END_POINTS[:folders]
      build_stub(filepath, :get, endpoint)
    end

    it "returns a correct stdout" do
      survey_monkey_tools = SurveyMonkeyTools::CLI.new

      expect { survey_monkey_tools.folders }.to output(@body).to_stdout
    end
  end

  describe "#create_folder" do
    before do
      filepath = "fixtures/surveymonkey/post_folders_response.json"
      endpoint = SurveyMonkeyTools::END_POINTS[:folders]
      build_stub(filepath, :post, endpoint)
    end

    it "returns a success response" do
      survey_monkey_tools = SurveyMonkeyTools::CLI.new

      stdout = "Folder is successfully created\nStatus: 201\n#{@body}"
      expect { survey_monkey_tools.create_folder("Teams Polls") }.to output(stdout).to_stdout
    end
  end

  def surveymonkey_request(method, endpoint)
    headers = {
      "Accept" => "application/json",
      "Authorization" => "Bearer #{ENV["ACCESS_TOKEN"]}"
    }
    headers["Content-Type"] = "application/json" if method == :post

    stub_request(method, "#{SurveyMonkeyTools::BASE_URI}/v3#{endpoint}").with(
      headers: headers
    )
  end

  def build_stub(filepath, method, endpoint)
    @body = File.read(File.join(__dir__, filepath))
    status = method == :post ? 201 : 200
    surveymonkey_request(method, endpoint).to_return(body: @body, status: status)
  end
end
