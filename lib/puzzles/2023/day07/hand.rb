# frozen_string_literal: true

require_relative "hand_type"

module AdventOfCode
  module Puzzles2023
    module Day07
      ##
      # Class for representing a hand of cards.
      class Hand
        ##
        # @return [String] string of cards
        attr_reader :cards

        ##
        # @return [Integer] bid
        attr_reader :bid

        ##
        # @param cards [String] string of cards
        # @param bid [Integer] bid
        def initialize(cards:, bid:)
          @cards = cards
          @bid = bid
        end

        ##
        # Type of the hand
        #
        # @return [Type] type of hand
        def type
          @type ||= HandType.new(hand: cards)
        end

        ##
        # Compare this hand with another hand.
        #
        # @param other [Hand] other hand to compare with
        #
        # @return [Integer] -1 if this hand is smaller, 0 if they are equal, 1 if this hand is bigger
        def <=>(other)
          return type.id <=> other.type.id unless type.id == other.type.id

          compare_cards(other.cards)
        end

        ##
        # Compare the cards of this hand with the cards of another hand.
        #
        # @param other_cards [String] cards of the other hand
        #
        # @return [Integer] -1 if this hand is smaller, 0 if they are equal, 1 if this hand is bigger
        def compare_cards(other_cards)
          cmp = 0
          cards.chars.zip(other_cards.chars).each do |a, b|
            if a != b
              cmp = cards_hierarchy.index(a) <=> cards_hierarchy.index(b)
              break
            end
          end
          cmp
        end

        protected

        ##
        # Hierarchy of cards, from lowest to highest.
        CARDS_HIERARCHY = %w[2 3 4 5 6 7 8 9 T J Q K A].freeze

        ##
        # Array of cards, from lowest to highest.
        #
        # @return [Array<String>] hierarchy of cards
        def cards_hierarchy
          CARDS_HIERARCHY
        end
      end
    end
  end
end
