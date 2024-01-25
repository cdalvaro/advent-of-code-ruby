# frozen_string_literal: true

require_relative "part1"

module AdventOfCode
  module Puzzles2023
    module Day10
      ##
      # Class for solving Day 10 - Part 2 puzzle
      class Part2 < Part1
        ##
        # @param file [String] The input file
        def initialize(file: nil)
          super
          @path = find_path
        end

        ##
        # Get the number of inner tiles inside the path.
        #
        # @return [Integer] The number of inner tiles inside the path
        def answer
          execute_block_with_real_starting_tile do
            count_inner_tiles
          end
        end

        protected

        ##
        # The path of the loop.
        # @return [Array<Tile>] The path of the loop
        attr_reader :path

        ##
        # Set of combinations that do not change the state (inside/outside) of the path.
        # @return [Set<Symbol>] Set of combinations
        NO_CHANGE_STATE_COMBINATIONS = %i[F7 LJ -- |F |L JL 7F 7L JF].to_set.freeze

        ##
        # Set of combinations that open the path horizontally.
        # @return [Set<Symbol>] Set of combinations
        OPEN_PATH_COMBINATIONS = %i[L- F-].to_set.freeze

        ##
        # Set of combinations that close the path horizontally.
        # @return [Set<Symbol>] Set of combinations
        CLOSE_PATH_COMBINATIONS = %i[-J -7].to_set.freeze

        ##
        # Count the number of inner tiles.
        #
        # This algorithm iterates over the rows of the data and
        # detects when the path is crossed so the tile is inside or outside the path.
        #
        # @return [Integer] The number of inner tiles
        def count_inner_tiles
          inner_tiles = 0
          data.each_with_index do |row, row_idx|
            tile_is_inside = nil
            crossing_path_with = nil
            row.each_with_index do |sym, column_idx|
              tile = Tile.new(sym:, pos: [row_idx, column_idx])
              tile_is_inside, crossing_path_with = tile_is_inside?(tile, tile_is_inside, crossing_path_with)
              inner_tiles += 1 if tile_is_inside && !path.include?(tile)
            end
          end
          inner_tiles
        end

        ##
        # Return whether the tile is inside the path or not.
        #
        # @param tile [Tile] The tile to check
        # @param previous_state [Boolean, nil] The state of the previous tile
        # @param crossing_path_with [Symbol, nil] Whether the previous tile was inside the path or not
        #
        # @return [Array<Boolean, Symbol>] A pair of booleans,
        #         the first one indicates whether the tile is inside the path or not
        #         the second one indicates whether the tile is crossing the path or not
        def tile_is_inside?(tile, previous_state, crossing_path_with)
          # If there is no previous state, this is the first tile of the row
          if previous_state.nil?
            is_inside = path.include?(tile) && tile.sym == :|
            return [is_inside, nil]
          end

          has_changed, crossing_path_with = state_has_changed?(tile, crossing_path_with)
          [has_changed ? !previous_state : previous_state, crossing_path_with]
        end

        ##
        # Check whether the state has changed or not regarding the current
        # tile and the previous one.
        # @param tile [Tile] The current tile
        # @param crossing_path_with [Symbol, nil] If not nil, it represents the opening state of the current path
        # @return [Array<Boolean, Symbol, nil>] A pair of boolean and symbol
        def state_has_changed?(tile, crossing_path_with)
          return [false, crossing_path_with] unless path.include?(tile)
          return [true, crossing_path_with] if tile.sym == :|

          previous_tile = previous_tile(tile:)
          return [false, nil] unless path.include?(previous_tile)

          # Both tiles are in the path
          combination = (previous_tile.sym.to_s + tile.sym.to_s).to_sym
          check_combination(combination, crossing_path_with)
        end

        ##
        # Check whether the combination of the current and the previous tile
        # opens, closes or does not change the state of the path.
        #
        # @param combination [Symbol] The combination of the current and the previous tile
        # @param crossing_path_with [Symbol, nil] If not nil, it represents the opening state of the current path
        #
        # @return [Array<Boolean, Symbol, nil>] A pair of boolean and symbol
        def check_combination(combination, crossing_path_with)
          # Is opening path?
          return [false, combination] if OPEN_PATH_COMBINATIONS.include?(combination)

          # Is closing path?
          if CLOSE_PATH_COMBINATIONS.include?(combination)
            # Remove unnecessary intermediate tiles
            combination = (crossing_path_with.to_s[0].to_s + combination.to_s[-1].to_s).to_sym
            crossing_path_with = nil
          end

          has_changed = !NO_CHANGE_STATE_COMBINATIONS.include?(combination)
          [has_changed, crossing_path_with]
        end

        ##
        # This method assumes that tiles at position [0,X]
        # are not going to be passed.
        #
        # @param tile [Tile] The tile to get the previous tile from
        #
        # @return [Tile] The previous tile
        def previous_tile(tile:)
          previous_pos = Movement::GO_LEFT.apply(to: tile.pos)
          Tile.new(sym: data[previous_pos[0]][previous_pos[1]], pos: previous_pos)
        end

        ##
        # Execute the given block after replacing the starting tile with the real one.
        # Once the block is executed, the starting tile is restored.
        #
        # @return [Untyped] The result of the block
        def execute_block_with_real_starting_tile
          starting_tile = find_starting_tile
          row, column = starting_tile.pos[0..1]

          data[row][column] = starting_tile.sym
          result = yield
        ensure
          data[row][column] = :S
          result
        end
      end
    end
  end
end
