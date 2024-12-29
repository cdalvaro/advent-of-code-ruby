# frozen_string_literal: true

require_relative "part1"

module AdventOfCode
  module Puzzles2024
    module Day05
      ##
      # Class for solving Day 5 (2024) - Part 2 puzzle
      class Part2 < Part1
        def answer
          invalid_updates.sum do |update|
            update = update_manager.fix_ordering(update:)
            middle_value(update)
          end
        end

        protected

        ##
        # Get the invalid updates
        # @return [Array<Array<Integer>>] The invalid updates
        def invalid_updates
          @updates - valid_updates
        end
      end
    end
  end
end
