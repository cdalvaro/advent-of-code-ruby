# frozen_string_literal: true

require_relative "part1"
require_relative "hand"

module AdventOfCode
  module Puzzles2023
    module Day07
      ##
      # Class for solving Day 7 - Part 2 puzzle
      class Part2 < Part1
        ##
        # Override HandType to treat jokers as the most common card.
        class HandType < Day07::HandType
          protected

          ##
          # Group cards treating the jokers as the most common card.
          #
          # @param hand [String] hand of cards
          #
          # @return [Array<Integer>] array of card counts
          def group_cards(hand)
            grouped = hand.chars.group_by(&:itself).to_h do |k, v|
              [k, v.size]
            end

            # Check for jokers
            if grouped.key?("J")
              # Replace jokers with the most common card
              jokers = grouped.delete("J")
              return [jokers] if grouped.empty?

              max_card = grouped.max_by { |_, v| v }&.first
              grouped[max_card] += jokers
            end

            grouped.values
          end
        end

        ##
        # Override Hand to use the new HandType.
        # Also, override the cards hierarchy to give jokers less weight.
        class Hand < Day07::Hand

          ##
          # Type of the hand
          #
          # @return [Type] type of hand
          def type
            @type ||= HandType.new(hand: cards)
          end

          protected

          ##
          # Hierarchy of cards, from lowest to highest.
          CARDS_HIERARCHY = %w[J 2 3 4 5 6 7 8 9 T Q K A].freeze

          ##
          # Array of cards, from lowest to highest.
          #
          # @return [Array<String>] hierarchy of cards
          def cards_hierarchy
            CARDS_HIERARCHY
          end
        end

        protected

        ##
        # Build a hand.
        #
        # @param cards [String] cards in the hand
        # @param bid [Integer] bid for the hand
        #
        # @return [Hand] hand
        def build_hand(cards, bid)
          Hand.new(cards:, bid:)
        end
      end
    end
  end
end
