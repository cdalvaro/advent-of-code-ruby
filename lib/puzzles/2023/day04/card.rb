# frozen_string_literal: true

module AdventOfCode
  module Puzzles2023
    module Day04
      ##
      # Class for representing a card
      class Card
        ##
        # @return [Integer] id of the card
        attr_reader :id

        ##
        # @return [Array<Integer>] array of owned numbers
        attr_reader :owned

        ##
        # @return [Array<Integer>] array of winning numbers
        attr_reader :winning

        ##
        # @param id [Integer] id of the card
        # @param owned [Array<Integer>] array of owned numbers
        # @param winning [Array<Integer>] array of winning numbers
        def initialize(id:, owned:, winning:)
          @id = id
          @owned = owned
          @winning = winning
        end

        ##
        # Get the matches of the card.
        # That is, the numbers that are both owned and winning.
        #
        # @return [Array<Integer>] array of matches
        def matches
          return @matches unless @matches.nil?

          @matches = winning.intersection(owned)
        end
      end
    end
  end
end
