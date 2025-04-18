# frozen_string_literal: true

require "cdalvaro/pair"
require_relative "part1"

module AdventOfCode
  module Puzzles2024
    module Day04
      ##
      # Class for solving Day 4 (2024) - Part 2 puzzle
      class Part2 < Part1
        def answer
          a_indexes = find_indexes_for(pattern: "A")
          a_indexes.count { |pair| pair_is_mas_cross(pair) }
        end

        protected

        ##
        # Check if the pair is a MAS cross
        # @param pair [Cdalvaro::Pair] The position of the A
        # @return [Boolean] True if the pair is a MAS cross, False otherwise
        def pair_is_mas_cross(pair)
          words = possible_movements(pair).map { |m| compose_word(m.first, m.second) }
          words.select! { |w| w == "MAS" }

          words.size == 2
        end

        ##
        # Return the movements of the diagonals for the given pair
        # @param pair [Cdalvaro::Pair] The position of the A
        # @return [Array<Cdalvaro::Pair>] The possible movements
        def possible_movements(pair)
          rows = (pair.first - 1..pair.first + 1).to_a
          cols = (pair.second - 1..pair.second + 1).to_a

          movements = []
          return movements unless check_bounds(rows, cols)

          ## Top left to bottom right
          movements << Cdalvaro::Pair.new(rows, cols)

          ## Bottom right to top left
          movements << Cdalvaro::Pair.new(rows.reverse, cols.reverse)

          ## Top right to bottom left
          movements << Cdalvaro::Pair.new(rows, cols.reverse)

          ## Bottom left to top right
          movements << Cdalvaro::Pair.new(rows.reverse, cols)

          movements
        end
      end
    end
  end
end
