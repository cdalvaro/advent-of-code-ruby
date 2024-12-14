# frozen_string_literal: true

require_relative "part1"

module AdventOfCode
  module Puzzles2024
    module Day01
      ##
      # Class for solving Day 1 - Part 2 puzzle
      class Part2 < Part1
        ##
        # Compute the answer for the puzzle.
        # The answer is the sum of all similarity scores.
        #
        # @return [Integer] answer for the puzzle
        def answer
          similarity_scores.sum
        end

        #
        # Compute the similarity scores for the puzzle.
        # The similarity score is computed as the number of times a number from list_a
        # appears in list_b multiplied by the number itself.
        #
        # @return [Array[Integer]] The array of similarity scores
        #
        def similarity_scores
          @similarity_scores = list_a.map do |a|
            a * list_b.count { |b| b == a }
          end
        end
      end
    end
  end
end
