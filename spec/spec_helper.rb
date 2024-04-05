# frozen_string_literal: true

ENV["RACK_ENV"] = "test"

require "yabeda/schked"

require "yabeda/rspec"
require_relative "support/schked"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:all) do
    Schked.config.logger = Logger.new(nil)
  end
end
