# frozen_string_literal: true

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "simplecov"
SimpleCov.start do
  enable_coverage :branch
  add_filter %r{^/test/}
end

require "simplecov-cobertura"
SimpleCov.formatter = SimpleCov::Formatter::CoberturaFormatter

require "minitest/autorun"
