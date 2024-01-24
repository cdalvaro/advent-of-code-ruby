# frozen_string_literal: true

module AdventOfCode
  module Puzzles2023
    module Day10
      ##
      # Class for representing a tile.
      class Tile
        ##
        # The symbol of the tile.
        # @return [Symbol] the symbol of the tile
        attr_reader :sym

        ##
        # The position of the tile.
        # @return [Array<Integer>] the position of the tile
        attr_reader :pos

        ##
        # @param sym [Symbol] The symbol of the tile
        # @param pos [Array<Integer>] The position of the tile
        def initialize(sym:, pos:)
          @sym = sym
          @pos = pos
        end

        ##
        # Check if the tile can connect to another tile in the direction given direction
        #
        # @param to [Tile] The tile to connect to
        # @param direction [Symbol] The direction to connect to
        #
        # @return [Boolean] True if the tile can connect to the other tile in the given direction
        def can_connect?(to:, direction:)
          connections = CONNECTIONS[sym]
          return false unless connections
          return true if connections[direction]&.include?(to.sym)

          connections.key?(direction) && to.sym == :S
        end

        ##
        # Check whether two tiles are the same
        #
        # @param other [Tile] The other tile to compare to
        #
        # @return [Boolean] True if the tiles are the same
        def ==(other)
          pos == other.pos
        end

        def to_s
          "#{sym} #{pos}"
        end

        ##
        # Hash with all possible connections for each tile
        # @return [Hash<Symbol, Hash<Symbol, Array<Symbol>>>] Hash with all possible connections for each tile
        CONNECTIONS = {
          :| => { up: %i[7 | F], down: %i[J | L] },
          :- => { left: %i[L - F], right: %i[J - 7] },
          :L => { up: %i[7 | F], right: %i[J - 7] },
          :J => { up: %i[7 | F], left: %i[L - F] },
          :"7" => { down: %i[J | L], left: %i[L - F] },
          :F => { down: %i[J | L], right: %i[J - 7] },
          :S => { up: %i[7 | F], down: %i[J | L], left: %i[L - F], right: %i[J - 7] }
        }.freeze
      end
    end
  end
end
