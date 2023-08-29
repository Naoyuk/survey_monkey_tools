# frozen_string_literal: true

require_relative "survey_monkey_tools/version"
require_relative "survey_monkey_tools/cli"
require_relative "survey_monkey_tools/surveys"
require_relative "survey_monkey_tools/endpoints"

module SurveyMonkeyTools
  class Error < StandardError; end
end
