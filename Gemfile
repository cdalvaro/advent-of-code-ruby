# frozen_string_literal: true

source "https://rubygems.org"

ruby file: ".ruby-version"

group :development do
  # bootstrapping
  gem "minitest", "~> 5.0"
  gem "rake", "~> 13.0"

  # rubocop
  gem "rubocop"
  gem "rubocop-minitest"
  gem "rubocop-performance"
  gem "rubocop-rake"
  gem "rubocop-shopify"

  # Type Signature for Ruby
  gem "rbs", "~> 3.8"

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
