# frozen_string_literal: true

module AdventOfCode
  module Puzzles2023
    module Day02
      ##
      # Set class to store the number of blue, green, and red cubes.
      class Set
        ##
        # @return [Integer] number of blue cubes
        attr_reader :blue

        ##
        # @return [Integer] number of green cubes
        attr_reader :green

        ##
        # @return [Integer] number of red cubes
        attr_reader :red

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
    end
  end
end
