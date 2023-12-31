# frozen_string_literal: true

module AdventOfCode
  module Puzzles2023
    module Day06
      ##
      # Class for representing a race
      class Race
        ##
        # @return [Integer] total time in milliseconds
        attr_reader :time

        ##
        # @return [Integer] distance to beat in millimeters
        attr_reader :distance

        ##
        # @param time [Integer] total time in milliseconds
        # @param distance [Integer] distance to beat in millimeters
        def initialize(time:, distance:)
          @time = time
          @distance = distance
        end
      end
    end
  end
end
