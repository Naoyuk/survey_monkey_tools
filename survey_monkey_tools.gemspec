# frozen_string_literal: true

require_relative "lib/survey_monkey_tools/version"

Gem::Specification.new do |spec|
  spec.name = "survey_monkey_tools"
  spec.version = SurveyMonkeyTools::VERSION
  spec.authors = ["Naoyuki Ishida"]
  spec.email = ["39.ishida@gmail.com"]

  spec.summary = "Tools for SurveyMonkey"
  spec.description = "Enable bulk copy"
  spec.homepage = "https://github.com/Naoyuk/survey_monkey_tools"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "https://github.com/Naoyuk/survey_monkey_tools"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/Naoyuk/survey_monkey_tools"
  spec.metadata["changelog_uri"] = "https://github.com/Naoyuk/survey_monkey_tools/CHANGELOG.md"

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "thor"
end
