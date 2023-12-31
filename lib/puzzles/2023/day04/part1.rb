# frozen_string_literal: true

require_relative "card"

module AdventOfCode
  module Puzzles2023
    module Day04
      ##
      # Class for solving Day 04 - Part 1 puzzle
      class Part1
        ##
        # @return [Array<Card>] array of cards
        attr_reader :cards

        ##
        # @param file [String] path to input file
        def initialize(file: nil)
          file ||= "#{File.dirname(__FILE__)}/input.txt"
          file_contents = File.readlines(file, chomp: true)
          parse_cards(file_contents)
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
        # Method to parse cards from file contents.
        #
        # @param file_contents [Array<String>] array of file lines
        #
        # @return [Array<Card>] array of cards
        def parse_cards(file_contents)
          @cards = file_contents.map do |line|
            match = %r{Card\s+(?<id>\d+): (?<winning>[0-9 ]+) \| (?<owned>[0-9 ]+)}.match(line)
            id = match[:id].to_i
            owned = match[:owned].split.map(&:to_i)
            winning = match[:winning].split.map(&:to_i)
            Card.new(id:, owned:, winning:)
          end
        end
      end
    end
  end
end
