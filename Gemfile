source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"

gem "rails", "~> 7.0.0"

gem "pg", "~> 1.1"

gem "puma", "~> 5.0"

gem 'active_model_serializers', '~> 0.10.0'

gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]


gem "bootsnap", require: false

group :development, :test do
  gem 'rspec-rails', '~> 6.1.0'
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  gem "letter_opener", "~> 1.8"
  gem 'colorize'
end

group :test do

gem "simplecov", "~> 0.22.0", :require => false

gem "simplecov_json_formatter", "~> 0.1.4", :require => false

end


gem "devise_token_auth", "~> 1.2"


gem "rack-cors", "~> 2.0"

