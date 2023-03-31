# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'

gem 'addressable', '~> 2.8'
gem 'bootsnap', require: false
gem 'faraday', '~> 2.7'
gem 'faraday-http', '~> 2'
gem 'gds-api-adapters', '~> 85'
# gem 'gds-sso' Not needed at the moment
gem 'govuk_app_config', '~> 5.0'
gem 'govuk_publishing_components', '~> 34'
gem 'pg', '~> 1.4'
gem 'pg_search'
gem 'plek', '~> 5.0'
gem 'rails', '~> 7.0'
gem 'rswag-api', '2.8'
gem 'rswag-ui', '2.8'
gem 'sassc-rails', '~> 2.1'
gem 'sentry-sidekiq', '~> 5.8'
gem 'sidekiq', '~> 7'
gem 'sidekiq-cron', '~> 1.9'
gem 'sprockets-rails', '~> 3.4'

# Pagination
gem 'govuk-components'
gem 'pagy', '~> 6.0', '>= 6.0.2'

group :development, :test do
  gem 'byebug', '~> 11'
  gem 'debug', '~> 1.7'
  gem 'dotenv-rails', '~> 2.8'
  gem 'govuk_test', '~> 3.0'
  gem 'rspec-rails', '~> 6.0.0'
  gem 'rswag-specs', '~> 2.8'
  gem 'rubocop-govuk', '~> 4.9'
end

group :development do
  gem 'listen', '~> 3.8'
  gem 'web-console', '~> 4.2'
end

group :test do
  gem 'capybara', '~> 3.38'
  gem 'database_cleaner-active_record', '~> 2'
  gem 'factory_bot_rails', '~> 6.2'
  gem 'faker', '~> 3'
  gem 'shoulda-matchers', '~> 5.0'
  gem 'simplecov', '~> 0.22'
  gem 'webmock', '~> 3.18'
end
