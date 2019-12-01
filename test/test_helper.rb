require 'simplecov'
SimpleCov.start 'rails'

require 'database_cleaner'
require 'database_cleaner_support'
DatabaseCleaner.strategy = :truncation

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'


class ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods
  # Run tests in parallel with specified workers
  # parallelize(workers: :number_of_processors)
end
