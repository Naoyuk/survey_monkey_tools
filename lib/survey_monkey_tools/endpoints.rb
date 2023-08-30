# frozen_string_literal: true

module SurveyMonkeyTools
  BASE_URI = "https://api.surveymonkey.com"
  END_POINTS = [
    { get_surveys_index: "/surveys" },
    { post_surveys: "/surveys" },
    { get_surveys_show: "/surveys/{id}" }
  ].freeze
  GET_SURVEYS = "/surveys"
end
