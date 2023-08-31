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
    context "when successfully accessed" do
      before do
        filepath = "fixtures/surveymonkey/get_surveys_response.json"
        body = File.read(File.join(__dir__, filepath))
        surveymonkey_request(SurveyMonkeyTools::END_POINTS[:surveys]).to_return(body: body, status: 200)
      end

      xit "outputs 201 status code" do
        # survey_monkey_tools = SurveyMonkeyTools::CLI.new
        # response = survey_monkey_tools.response(SurveyMonkeyTools::END_POINTS[:surveys])

        expect { SurveyMonkeyTools::CLI.surveys }.to output("200").to_stdout
      end

      xit "returns a correct stdout" do
        survey_monkey_tools = SurveyMonkeyTools::CLI.new
        response = survey_monkey_tools.response(SurveyMonkeyTools::END_POINTS[:surveys])

        expect(response.code.to_i).to eq(200)
      end
    end
  end

  describe "#folders" do
    before do
      filepath = "fixtures/surveymonkey/get_folders_response.json"
      body = File.read(File.join(__dir__, filepath))
      surveymonkey_request(SurveyMonkeyTools::END_POINTS[:folders]).to_return(body: body, status: 200)
    end

    it "returns a success response" do
      survey_monkey_tools = SurveyMonkeyTools::CLI.new
      response = survey_monkey_tools.response(SurveyMonkeyTools::END_POINTS[:folders])

      expect(response.code.to_i).to eq(200)
    end

    it "returns a correct stdout"
  end

  describe "#create_folder" do
    it "returns a success response"
  end

  def surveymonkey_request(endpoint)
    stub_request(:get, "#{SurveyMonkeyTools::BASE_URI}/v3#{endpoint}").with(
      headers: {
        "Accept" => "application/json",
        "Authorization" => "Bearer #{ENV["ACCESS_TOKEN"]}"
      }
    )
  end
end
