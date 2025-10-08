# frozen_string_literal: true

source "https://rubygems.org"

ruby file: ".ruby-version"

group :development do
  # bootstrapping
  gem "minitest", "~> 5.26"
  gem "minitest-ci"
  gem "rake", "~> 13.3"

  # rubocop
  gem "rubocop"
  gem "rubocop-minitest"
  gem "rubocop-performance"
  gem "rubocop-rake"
  gem "rubocop-shopify"

  # Type Signature for Ruby
  gem "rbs", "~> 3.9"

  # Steep
  gem "steep"

  # Overcommit
  gem "overcommit"
end

group :test do
  # codecov
  gem "simplecov"
  gem "simplecov-cobertura"
end
