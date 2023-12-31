# frozen_string_literal: true

module AdventOfCode
  module Puzzles2023
    module Day05
      ##
      # Class for representing a relation.
      class Relation
        ##
        # @param source [Range] range of source values
        # @param destination [Range] range of destination values
        def initialize(source:, destination:)
          @source = source
          @destination = destination
        end

        ##
        # Convert a source value to destination value.
        # If value is not in source range, return nil.
        #
        # @param value [Integer] source value to convert
        #
        # @return [Integer, nil] destination value or nil if value is not in source range
        def convert(value:)
          # Is value in source range?
          return unless @source.include?(value)

          # Then, convert to destination range
          @destination.begin + (value - @source.begin)
        end
      end
    end
  end
end
