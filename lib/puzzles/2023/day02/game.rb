# frozen_string_literal: true

module AdventOfCode
  module Puzzles2023
    module Day02
      ##
      # Game class to store the game id and its sets.
      class Game
        ##
        # @return [Integer] game id
        attr_reader :id

        ##
        # @return [Array<Set>] sets of cubes
        attr_reader :sets

        ##
        # @param id [Integer] game id
        # @param sets [Array<Set>] sets of cubes
        def initialize(id:, sets:)
          @id = id
          @sets = sets
        end

        ##
        # Check if the game is valid given the number of blue, green,
        # and red cubes.
        #
        # @param blue [Integer] number of blue cubes
        # @param green [Integer] number of green cubes
        # @param red [Integer] number of red cubes
        #
        # @return [Boolean] true if the game is valid, false otherwise
        def valid?(blue:, green:, red:)
          # A game is valid only if every set has the same or less
          # number of blue, green, and red cubes as the set it is
          sets.each do |set|
            return false if set.blue > blue
            return false if set.green > green
            return false if set.red > red
          end
          true
        end
      end
    end
  end
end
