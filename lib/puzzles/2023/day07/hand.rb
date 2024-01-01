# frozen_string_literal: true

require_relative 'hand_type'

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

          cards.chars.zip(other.cards.chars).each do |a, b|
            next if a == b

            return cards_hierarchy.index(a) <=> cards_hierarchy.index(b)
          end

          0
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
