# frozen_string_literal: true

require_relative "part1"
require_relative "set"

module AdventOfCode
  module Puzzles2023
    module Day02
      ##
      # Class for solving Day 02 - Part 2 puzzle
      class Part2 < Part1
        ##
        # Find the sum of the powers for the minimum valid sets.
        #
        # @return [Integer] sum of the powers
        def answer
          minimum_valid_sets.values.sum(&:power)
        end

        ##
        # Find the minimum valid set for each game.
        #
        # @return [Hash<Game, Set>] minimum valid sets
        def minimum_valid_sets
          @minimum_valid_sets ||= games.to_h { |game| [game, minimum_valid_set_for(game:)] }
        end

        protected

        ##
        # Array of colors
        # @return [Array<Symbol>] the colors of the cubes
        COLORS = %i[blue green red].freeze

        ##
        # Find the minimum valid set for a game.
        # The minimum valid set is the set with the maximum number of
        # blue, green, and red cubes for all sets.
        #
        # @param game [Game] game to find the minimum valid set for
        #
        # @return [Set] minimum valid set
        def minimum_valid_set_for(game:)
          # Find the maximum number of blue, green, and red cubes in each set
          minimum_set = COLORS.to_h { |color| [color, 0] }
          game.sets.each do |set|
            COLORS.each do |color|
              minimum_set[color] = [set.send(color), minimum_set[color]].max
            end
          end
          Set.new(**minimum_set)
        end
      end
    end
  end
end
