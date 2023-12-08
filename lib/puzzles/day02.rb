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

      class Game
        attr_reader :id, :sets

        def initialize(id:, sets:)
          @id = id
          @sets = sets
        end

        def valid?(blue:, green:, red:)
          # A game is valid only if every set has the same or less
          # number of blue, green, and red cubes as the set it is
          sets.each do |set|
            return false if set.blue && set.blue > blue
            return false if set.green && set.green > green
            return false if set.red && set.red > red
          end
          true
        end
      end

      ##
      # Class for solving Day 02 - Part 1 puzzle
      class Part1
        attr_reader :games

        def initialize(file:)
          file_contents = File.readlines(file, chomp: true)
          load_games_from_contents(file_contents)
        end

        def valid_games(blue:, green:, red:)
          games.select { |game| game.valid?(blue:, green:, red:) }
        end

        def answer(kargs)
          valid_games(**kargs).map(&:id).sum
        end

        protected

        def load_games_from_contents(file_contents)
          @games = file_contents.map do |line|
            id, sets = line.split(": ")
            sets = sets.split("; ").map do |set|
              colors = set.split(", ").map(&:split)
              colors = colors.to_h { |number, color| [color.downcase.to_sym, number.to_i] }
              Set.new(**colors)
            end
            id = id.gsub!("Game ", "").to_i
            Game.new(id:, sets:)
          end
        end
      end

      class Part2 < Part1
        def answer
          minimum_valid_sets.values.map(&:power).sum
        end

        def minimum_valid_sets
          @minimum_valid_sets ||= games.to_h do |game|
            minimum_set = { blue: 0, green: 0, red: 0 }
            game.sets.each do |set|
              minimum_set[:blue] = set.blue if set.blue && set.blue > minimum_set[:blue]
              minimum_set[:green] = set.green if set.green && set.green > minimum_set[:green]
              minimum_set[:red] = set.red if set.red && set.red > minimum_set[:red]
            end
            [game, Set.new(**minimum_set)]
          end
        end
      end
    end
  end
end
