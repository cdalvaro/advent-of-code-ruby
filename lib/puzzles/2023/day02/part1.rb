# frozen_string_literal: true

require_relative "game"
require_relative "set"

module AdventOfCode
  module Puzzles2023
    module Day02
      ##
      # Class for solving Day 2 - Part 1 puzzle
      class Part1
        ##
        # Array of games
        # @return [Array<Game>] the games of the puzzle
        attr_reader :games

        ##
        # @param file [String] path to the input file
        def initialize(file: nil)
          file ||= "#{File.dirname(__FILE__)}/input.txt"
          file_contents = File.readlines(file, chomp: true)
          load_games(file_contents)
        end

        ##
        # Find games that are valid given the number of blue, green,
        # and red cubes.
        #
        # @param blue [Integer] number of blue cubes
        # @param green [Integer] number of green cubes
        # @param red [Integer] number of red cubes
        #
        # @return [Array<Game>] valid games
        def valid_games(blue:, green:, red:)
          games.select { |game| game.valid?(blue:, green:, red:) }
        end

        ##
        # Find the sum of the game ids that are valid given the number
        # of blue, green, and red cubes.
        #
        # @param blue [Integer] number of blue cubes
        # @param green [Integer] number of green cubes
        # @param red [Integer] number of red cubes
        #
        # @return [Integer] sum of the game ids
        def answer(blue:, green:, red:)
          valid_games(blue:, green:, red:).sum(&:id)
        end

        protected

        ##
        # Load games from the file contents.
        #
        # @param file_contents [Array<String>] file contents
        #
        # @return [Array<Game>] games
        def load_games(file_contents)
          @games = file_contents.map do |line|
            id, sets = line.split(": ")
            sets = sets.split(%r{;\s+}).map { |set| parse_set(set) }
            game_id = parse_game_id(id)
            Game.new(id: game_id, sets:)
          end
        end

        ##
        # Parse the game id from a string.
        # The string is in the format "Game X".
        #
        # @param game [String] game id
        #
        # @return [Integer] game id
        def parse_game_id(game)
          game.gsub("Game ", "").to_i
        end

        ##
        # Parse a set of cubes from a string.
        # The string is in the format "X blue, Y green, Z red".
        #
        # @param set [String] set of cubes
        #
        # @return [Set] set of cubes
        def parse_set(set)
          colors = set.split(%r{,\s+}).map(&:split)
          colors = colors.to_h { |number, color| [color.downcase.to_sym, number.to_i] }
          Set.new(**colors)
        end
      end
    end
  end
end
