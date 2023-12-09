# frozen_string_literal: true

module AdventOfCode
  module Puzzles
    ##
    # Advent of Code 2023 - Day 2
    # https://adventofcode.com/2023/day/2
    module Day02
      ##
      # Set class to store the number of blue, green, and red cubes.
      class Set
        attr_reader :blue, :green, :red

        ##
        # @param blue [Integer] number of blue cubes
        # @param green [Integer] number of green cubes
        # @param red [Integer] number of red cubes
        def initialize(blue: 0, green: 0, red: 0)
          @blue = blue
          @green = green
          @red = red
        end

        ##
        # Compute the power of the set by multiplying the number of
        # blue, green, and red cubes.
        #
        # @return [Integer] power of the set
        def power
          return @power if @power

          @power = (blue || 1) * (green || 1) * (red || 1)
        end
      end

      ##
      # Game class to store the game id and its sets.
      class Game
        attr_reader :id, :sets

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

      ##
      # Class for solving Day 02 - Part 1 puzzle
      class Part1
        attr_reader :games

        ##
        # @param file [String] path to the input file
        def initialize(file:)
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
          valid_games(blue:, green:, red:).map(&:id).sum
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

      ##
      # Class for solving Day 02 - Part 2 puzzle
      class Part2 < Part1
        ##
        # Find the sum of the powers for the minimum valid sets.
        #
        # @return [Integer] sum of the powers
        def answer
          minimum_valid_sets.values.map(&:power).sum
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
        # Find the minimum valid set for a game.
        # The minimum valid set is the set with the maximum number of
        # blue, green, and red cubes for all sets.
        #
        # @param game [Game] game to find the minimum valid set for
        #
        # @return [Set] minimum valid set
        def minimum_valid_set_for(game:)
          # Find the maximum number of blue, green, and red cubes in each set
          minimum_set = { blue: 0, green: 0, red: 0 }
          game.sets.each do |set|
            %i[blue green red].each do |color|
              minimum_set[color] = [set.send(color), minimum_set[color]].max
            end
          end
          Set.new(**minimum_set)
        end
      end
    end
  end
end
