# frozen_string_literal: true

module AdventOfCode
  module Puzzles2023
    module Day05
      ##
      # Class for converting values from source to destination.
      class Converter
        ##
        # @return [Symbol] source of the conversion
        attr_reader :source

        ##
        # @return [Symbol] destination of the conversion
        attr_reader :destination

        ##
        # @param source [Symbol] source of the conversion
        # @param destination [Symbol] destination of the conversion
        # @param relations [Array<Relation>] array of relations
        def initialize(source:, destination:, relations:)
          @source = source
          @destination = destination
          @relations = relations
        end

        ##
        # Convert a value from source to destination.
        #
        # @param value [Integer] value to convert
        #
        # @return [Integer] converted value
        def convert(value:)
          # Find value in maps
          @relations.each do |relation|
            if (result = relation.convert(value:))
              return result
            end
          end
          value
        end
      end
    end
  end
end
