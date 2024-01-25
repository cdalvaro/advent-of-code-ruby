# frozen_string_literal: true

require_relative "movement"
require_relative "tile"

module AdventOfCode
  module Puzzles2023
    module Day10
      ##
      # Class for solving Day 10 - Part 1 puzzle
      class Part1
        ##
        # @param file [String] The input file
        def initialize(file: nil)
          file ||= "#{File.dirname(__FILE__)}/input.txt"
          parse_file(file)
        end

        ##
        # Get the number of steps to the furthest tile.
        #
        # @return [Integer] The number of steps to the furthest tile
        def answer
          find_path.length / 2
        end

        protected

        ##
        # A sketch of all of the surface tiles.
        # @return [Array<Array<Symbol>>] A sketch of all of the surface tiles
        attr_reader :data

        ##
        # Parse the input file.
        # @param file [String] The input file
        def parse_file(file)
          @data = File.readlines(file).map { |line| line.chomp.chars.map(&:to_sym) }
        end

        ##
        # Find the tile with the :S symbol, and replace it with the real tile.
        #
        # @return [Tile] The real tile
        def find_starting_tile
          row = column = nil
          data.each_with_index do |line, row_index|
            line.each_with_index do |char, column_index|
              next unless char == :S

              row = row_index
              column = column_index
              break
            end
            break if row && column
          end

          replace_s_with_real_tile(s_tile: Tile.new(sym: :S, pos: [row, column]))
        end

        ##
        # Replace the :S tile with the real tile.
        #
        # @param s_tile [Tile] The :S tile
        #
        # @return [Tile] The real tile
        def replace_s_with_real_tile(s_tile:)
          # S neighbors
          directions = %i[up down left right]
          neighbor_tiles = directions.to_h { |dir| [dir, next_tile(from: s_tile, direction: dir)] }
                                     .compact

          # Find tiles that connects with two neighbors
          tiles = %w[| - L J 7 F].map { |sym| Tile.new(sym: sym.to_sym, pos: s_tile.pos) }
          tiles.select! do |tile|
            connections = neighbor_tiles.filter { |direction, neighbour| tile.can_connect?(to: neighbour, direction:) }
            connections.size == 2
          end

          tiles[0]
        end

        ##
        # Find the closed path.
        #
        # @return [Array<Tile>] The closed path
        def find_path
          path = []
          tile = find_starting_tile
          path << tile
          previous = tile
          loop do
            new_tile = find_next_tile(from: tile, previous:)
            break if new_tile.sym == :S

            path << new_tile
            previous = tile
            tile = new_tile
          end
          path
        end

        ##
        # Get the next tile from the given tile in the given direction.
        #
        # @param from [Tile] The tile to start from
        # @param direction [Symbol] The direction to go
        #
        # @return [Tile] The next tile
        def next_tile(from:, direction:)
          movement = case direction
                     when :up
                       Movement::GO_UP
                     when :down
                       Movement::GO_DOWN
                     when :right
                       Movement::GO_RIGHT
                     else
                       Movement::GO_LEFT
                     end

          pos = movement.apply(to: from.pos)
          return unless valid_pos?(pos)

          sym = data[pos[0]][pos[1]]
          tile = Tile.new(sym:, pos:)
          return unless from.can_connect?(to: tile, direction:)

          tile
        end

        ##
        # Check whether the given position is inside the bounds of the data.
        #
        # @param pos [Array<Integer>] The position to check
        #
        # @return [Boolean] True if the position is inside the bounds of the data
        def valid_pos?(pos)
          return false unless pos[0].between?(0, data.size - 1)
          return false unless pos[1].between?(0, data[pos[0]].size - 1)

          true
        end

        ##
        # Find the next tile that connects to the current tile.
        #
        # @param from [Tile] The current tile
        # @param previous [Tile] The previous tile (to avoid going back)
        #
        # @return [Tile] The next tile
        def find_next_tile(from:, previous:) # rubocop:disable Metrics/CyclomaticComplexity
          # Can go up?
          if (new_tile = next_tile(from:, direction: :up)) && new_tile != previous
            return new_tile
          end

          # Can go right?
          if (new_tile = next_tile(from:, direction: :right)) && new_tile != previous
            return new_tile
          end

          # Can go down?
          if (new_tile = next_tile(from:, direction: :down)) && new_tile != previous
            return new_tile
          end

          # Must be left
          new_tile = next_tile(from:, direction: :left)
          raise "No tile found" unless new_tile

          new_tile
        end
      end
    end
  end
end
