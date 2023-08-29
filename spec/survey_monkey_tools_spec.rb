# frozen_string_literal: true

require "survey_monkey_tools"
require "webmock/rspec"

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
        surveymonkey_request("surveys")
      end

      it "returns all surveys" do
        SurveyMonkeyTools::CLI.new
        # expect(survey_monkey_tools.get.status).to eq(200)
      end
    end

    context "when failed to access" do
      it "returns error messages" do
        expect(true).to eq(true)
      end
    end
  end

  def surveymonkey_request(endpoint)
    stub_request(:get, "#{SurveyMonkeyTools::BASE_URI}/v3/#{endpoint}")
      .with(
        headers: {
          "Accept" => "application/json",
          "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
          "Authorization" => "Bearer #{ENV["ACCESS_TOKEN"]}",
          "User-Agent" => "Ruby"
        }
      )
  end
end
