# frozen_string_literal: true

module AdventOfCode
  module Puzzles2023
    module Day03
      ##
      # Class for representing a gear
      class Gear
        ##
        # @return [String] symbol of the gear
        attr_reader :symbol

        ##
        # @return [String] index of the gear
        attr_reader :index

        ##
        # @return [Array<Integer>] array of numbers of the gear
        attr_reader :numbers

        ##
        # @param symbol [String] symbol of the gear
        # @param index [String] index of the gear
        # @param numbers [Array<Integer>] array of numbers of the gear
        def initialize(symbol:, index:, numbers:)
          @symbol = symbol
          @index = index
          @numbers = numbers
        end

        ##
        # Get the ratio of the gear.
        #
        # @return [Integer] ratio of the gear
        def ratio
          @ratio ||= numbers.reduce(:*)
        end
      end
    end
  end
end
