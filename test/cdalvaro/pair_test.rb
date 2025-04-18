# frozen_string_literal: true

require "test_helper"
require "cdalvaro/pair"

module Cdalvaro
  class PairTest < ActiveSupport::TestCase
    def setup
      # Do nothing
    end

    def teardown
      # Do nothing
    end

    def test_readers
      pair = Pair.new("Hello", :world)

      assert_equal "Hello", pair.first
      assert_equal :world, pair.second
    end

    def test_writers
      pair = Pair.new("Hello", :world)

      pair.first = :earth
      pair.second = "Goodbye"

      assert_equal :earth, pair.first
      assert_equal "Goodbye", pair.second
    end
  end
end
