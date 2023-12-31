# frozen_string_literal: true

require_relative "part1"

module AdventOfCode
  module Puzzles2023
    module Day04
      ##
      # Class for solving Day 04 - Part 2 puzzle
      class Part2 < Part1
        ##
        # Get the total number of cards.
        #
        # @return [Integer] total number of cards
        def answer
          total_cards.sum { |c| c[:copies] }
        end

        ##
        # Array of cards, with each card having a copies attribute.
        #
        # @return [Array<Hash<String, Card|Integer>>] array of cards with copies counter
        def total_cards
          # Initialize every element of the array with one copy of each card
          cards_h = cards.map { |card| { card:, copies: 1 } }

          # Count cards
          cards_h.each do |item|
            # This is the number of copies of the card that we already have
            current_copies = item[:copies]

            # New cards that are won by the card
            won_cards = get_matching_cards(card: item[:card])
            won_cards.each do |won_card|
              cards_h[won_card.id - 1][:copies] += current_copies
            end
          end

          cards_h
        end

        protected

        ##
        # Get the cards that are won by the card.
        # That is, one copy of the following `n` cards, where `n` is the
        # number of matches of the card.
        #
        # @return [Array<Card>] array of card ids
        def get_matching_cards(card:)
          number_of_copies = card.matches.length
          cards[card.id, number_of_copies] || []
        end
      end
    end
  end
end
