# frozen_string_literal: true

require_relative "part1"

module AdventOfCode
  module Puzzles2023
    module Day06
      ##
      # Class for solving Day 6 - Part 2 puzzle
      class Part2 < Part1
        protected

        ##
        # Parse the values from the file contents for a given key.
        #
        # @param file_contents [Array<String>] array of lines
        # @param key [String] key to find
        #
        # @return [Array<Integer>] array of values
        def parse_values(file_contents, key:)
          values = super
          [values.join.to_i]
        end
      end
    end
  end
end
