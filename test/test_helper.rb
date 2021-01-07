require 'simplecov'
SimpleCov.start 'test_frameworks'

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)

require 'quick_random_records'
require 'minitest/autorun'

ActiveRecord::Base.establish_connection(
  "adapter"  => "sqlite3",
  "database" => ":memory:"
)

require 'seeds'
