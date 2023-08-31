# frozen_string_literal: true

module SurveyMonkeyTools
  BASE_URI = "https://api.surveymonkey.com"
  END_POINTS = {
    surveys: "/surveys",
    survey: "/surveys/{id}",
    folders: "/survey_folders"
  }.freeze
end
