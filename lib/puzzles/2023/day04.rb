# frozen_string_literal: true

module AdventOfCode
  module Puzzles2023
    ##
    # Advent of Code 2023 - Day 4
    # https://adventofcode.com/2023/day/4
    module Day04
      ##
      # Class for representing a card
      class Card
        attr_reader :id, :owned, :winning

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

      ##
      # Class for solving Day 04 - Part 1 puzzle
      class Part1
        attr_reader :cards

        ##
        # @param file [String] path to input file
        def initialize(file:)
          file_contents = File.readlines(file, chomp: true)
          @cards = extract_cards(file_contents)
        end

        ##
        # Get the sum of the points of the cards.
        def answer
          points.sum
        end

        ##
        # Get the points of the cards.
        #
        # The points are calculated as 2^(n-1), where n is the number
        # of matches of the card.
        # If the card has no matches, it gets 0 points.
        #
        # @return [Array<Integer>] array of points
        def points
          cards.map do |card|
            matches = card.matches.length
            matches.zero? ? 0 : (2**(matches - 1)).to_i
          end
        end

        protected

        ##
        # Method to extract cards from file contents.
        #
        # @param file_contents [Array<String>] array of file lines
        #
        # @return [Array<Card>] array of cards
        def extract_cards(file_contents)
          cards = []
          file_contents.each do |line|
            match = %r{Card\s+(?<id>\d+): (?<winning>[0-9 ]+) \| (?<owned>[0-9 ]+)}.match(line)
            id = match[:id].to_i
            owned = match[:owned].split.map(&:to_i)
            winning = match[:winning].split.map(&:to_i)
            cards << Card.new(id:, owned:, winning:)
          end
          cards
        end
      end

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
