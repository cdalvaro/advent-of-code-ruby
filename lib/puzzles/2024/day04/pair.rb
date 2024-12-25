# frozen_string_literal: true

module AdventOfCode
  module Puzzles2024
    module Day04
      ## Class for representing a pair
      class Pair
        ##
        ## The first element of the pair
        # @return [Integer] The first element of the pair
        attr_reader :first

        ##
        # The second element of the pair
        # @return [Integer] The second element of the pair
        attr_reader :second

        def initialize(first, second)
          @first = first
          @second = second
        end

        def to_s
          "[#{first}, #{second}]"
        end
      end
    end
  end
end
