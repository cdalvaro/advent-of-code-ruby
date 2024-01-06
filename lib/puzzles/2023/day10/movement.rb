# frozen_string_literal: true

module AdventOfCode
  module Puzzles2023
    module Day10
      ##
      # Class for representing a movement.
      class Movement
        ##
        # Apply the movement to the given position.
        #
        # @param to [Array<Integer>] The position to apply the movement to
        #
        # @return [Array<Integer>] The new position
        def apply(to:)
          to.zip(movement).map { |a, b| a + b }
        end

        protected

        ##
        # The movement.
        # @return [Array<Integer>] The movement
        attr_reader :movement

        ##
        # @param movement [Array<Integer>] The movement
        def initialize(movement:)
          @movement = movement
        end

        ##
        # Movement to go up.
        # @return [Movement] Movement to go up
        GO_UP = new(movement: [-1, 0])

        ##
        # Movement to go down.
        # @return [Movement] Movement to go down
        GO_DOWN = new(movement: [1, 0])

        ##
        # Movement to go right.
        # @return [Movement] Movement to go right
        GO_RIGHT = new(movement: [0, 1])

        ##
        # Movement to go left.
        # @return [Movement] Movement to go left
        GO_LEFT = new(movement: [0, -1])
      end
    end
  end
end
