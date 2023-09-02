# SurveyMonkeyTools

This is a utility tools for bulk duplicating new surveys from existing surveys.

## Installation

    $ copy .env.example .env

Replace the placeholder in `.env` with your own Access Token of SurveyMonkey App.  
Set GitHub Secrets named ACCESS_TOKEN.

## Usage

To GET all surveys list

    $ bundle exec ruby exe/survey_monkey_tools surveys

To POST survey (Disable from command line. This can be used by calling as subcommand)

    $ bundle exec ruby exe/survey_monkey_tools post_survey {'key1':'value1', 'key2':'value2'}

To PATCH survey (Disable from command line. This can be used by calling as subcommand)

    $ bundle exec ruby exe/survey_monkey_tools patch_survey id {'key1':'value1', 'key2':'value2'}

To GET all survey folders list

    $ bundle exec ruby exe/survey_monkey_tools folders

To POST folder

    $ bundle exec ruby exe/survey_monkey_tools post_folder {folder_name}

## Features

- GET /surveys
- POST /surveys
- PATCH /survey/{id}
- GET /survey_folders
- POST /survey_folders

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Naoyuk/survey_monkey_tools. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/Naoyuk/survey_monkey_tools/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the SurveyMonkeyTools project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/Naoyuk/survey_monkey_tools/blob/main/CODE_OF_CONDUCT.md).
