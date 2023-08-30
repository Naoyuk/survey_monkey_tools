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

  describe "#get" do
    context "when successfully accessed" do
      before do
        filepath = "fixtures/surveymonkey/get_surveys_response.json"
        body = File.read(File.join(__dir__, filepath))
        surveymonkey_request("surveys").to_return(body: body, status: 200)
      end

      it "returns a success response" do
        survey_monkey_tools = SurveyMonkeyTools::CLI.new
        response = survey_monkey_tools.response_get_surveys

        expect(response.code.to_i).to eq(200)
      end
    end
  end

  def surveymonkey_request(endpoint)
    stub_request(:get, "#{SurveyMonkeyTools::BASE_URI}/v3/#{endpoint}").with(
      headers: {
        "Accept" => "application/json",
        "Authorization" => "Bearer #{ENV["ACCESS_TOKEN"]}"
      }
    )
  end
end
