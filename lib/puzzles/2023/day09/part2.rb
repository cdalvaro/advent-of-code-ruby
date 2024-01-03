# frozen_string_literal: true

require_relative "part1"

module AdventOfCode
  module Puzzles2023
    module Day09
      ##
      # Class for solving Day 9 - Part 2 puzzle
      class Part2 < Part1
        protected

        ##
        # Predict a previous value of a feature.
        #
        # @param [Feature] feature
        #
        # @return [Integer] predicted value
        def predict(feature:)
          history = 0
          compute_differences(feature:).reverse_each do |diffs|
            history = diffs.first - history
          end
          history
        end
      end
    end
  end
end
