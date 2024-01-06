# frozen_string_literal: true

module AdventOfCode
  module Puzzles2023
    module Day10
      ##
      # Class for representing a pipe.
      class Pipe
        ##
        # The symbol of the pipe.
        # @return [Symbol] the symbol of the pipe
        attr_reader :sym

        ##
        # The position of the pipe.
        # @return [Array<Integer>] the position of the pipe
        attr_reader :pos

        ##
        # @param sym [Symbol] The symbol of the pipe
        # @param pos [Array<Integer>] The position of the pipe
        def initialize(sym:, pos:)
          @sym = sym
          @pos = pos
        end

        ##
        # Check if the pipe can connect to another pipe in the direction given direction
        #
        # @param to [Pipe] The pipe to connect to
        # @param direction [Symbol] The direction to connect to
        #
        # @return [Boolean] True if the pipe can connect to the other pipe in the given direction
        def can_connect?(to:, direction:)
          connections = CONNECTIONS[sym]
          return false unless connections
          return true if connections[direction]&.include?(to.sym)

          to.sym == :S
        end

        ##
        # Check whether two pipes are the same
        #
        # @param other [Pipe] The other pipe to compare to
        #
        # @return [Boolean] True if the pipes are the same
        def ==(other)
          pos == other.pos
        end

        ##
        # Hash with all possible connections for each pipe
        # @return [Hash<Symbol, Hash<Symbol, Array<Symbol>>>] Hash with all possible connections for each pipe
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
