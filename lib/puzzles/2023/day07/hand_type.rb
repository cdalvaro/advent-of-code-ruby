# frozen_string_literal: true

module AdventOfCode
  module Puzzles2023
    module Day07
      ##
      # Class for representing the type of a hand.
      class HandType
        ##
        # Identifier of the hand, valid for sorting.
        # @return [Integer] id of the hand type
        attr_reader :id

        ##
        # Name of the hand type.
        # @return [String] name of the hand type
        attr_reader :name

        ##
        # @param hand [String] string of cards
        def initialize(hand:)
          raise "Invalid size for hand: #{hand}" unless hand.size == 5
          @id, @name = find_type(hand)
        end

        protected

        ##
        # High card hand type.
        # @return [String] name of the hand type
        HIGH_CARD = "High card"

        ##
        # One pair hand type.
        # @return [String] name of the hand type
        ONE_PAIR = "One pair"

        ##
        # Two pairs hand type.
        # @return [String] name of the hand type
        TWO_PAIRS = "Two pairs"

        ##
        # Three of a kind hand type.
        # @return [String] name of the hand type
        THREE_OF_A_KIND = "Three of a kind"

        ##
        # Full house hand type.
        # @return [String] name of the hand type
        FULL_HOUSE = "Full house"

        ##
        # Four of a kind hand type.
        # @return [String] name of the hand type
        FOUR_OF_A_KIND = "Four of a kind"

        ##
        # Five of a kind hand type.
        # @return [String] name of the hand type
        FIVE_OF_A_KIND = "Five of a kind"

        ##
        # Sorted list of hand types, from lowest to highest.
        # @return [Array<String>] sorted list of hand types
        SORTED_TYPES = [HIGH_CARD, ONE_PAIR, TWO_PAIRS, THREE_OF_A_KIND, FULL_HOUSE, FOUR_OF_A_KIND,
                        FIVE_OF_A_KIND].freeze

        ##
        # Find the type of the hand.
        #
        # @param hand [String] string of cards
        #
        # @return [Array<Integer, String>] id and name of the hand type
        def find_type(hand)
          # Count the number of repeated cards
          count = group_cards(hand)

          # Discard lonely cards
          count = count.select { |c| c > 1 }

          case count.sort
          when [5]
            # Five repeated cards
            [SORTED_TYPES.index(FIVE_OF_A_KIND), FIVE_OF_A_KIND]
          when [4]
            # Four repeated cards
            [SORTED_TYPES.index(FOUR_OF_A_KIND), FOUR_OF_A_KIND]
          when [2, 3]
            # Three repeated cards and two repeated cards
            [SORTED_TYPES.index(FULL_HOUSE), FULL_HOUSE]
          when [3]
            # Three repeated cards
            [SORTED_TYPES.index(THREE_OF_A_KIND), THREE_OF_A_KIND]
          when [2, 2]
            # Two groups of two repeated cards
            [SORTED_TYPES.index(TWO_PAIRS), TWO_PAIRS]
          when [2]
            # Two repeated cards
            [SORTED_TYPES.index(ONE_PAIR), ONE_PAIR]
          else
            # No repeated cards
            [SORTED_TYPES.index(HIGH_CARD), HIGH_CARD]
          end
        end

        ##
        # Group cards and count the number of repeated cards.
        #
        # @param hand [String] string of cards
        #
        # @return [Array<Integer>] array of card counts
        def group_cards(hand)
          hand.chars.group_by(&:itself).values.map(&:size)
        end
      end
    end
  end
end
