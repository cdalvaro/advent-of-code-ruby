# frozen_string_literal: true

require_relative "hand"

module AdventOfCode
  module Puzzles2023
    module Day07
      ##
      # Class for solving Day 7 - Part 1 puzzle
      class Part1
        ##
        # @return [Array<Hand>] hands to play with
        attr_reader :hands

        ##
        # @param file [String] file name of the input file
        def initialize(file: nil)
          file ||= "#{File.dirname(__FILE__)}/input.txt"
          parse_file(file)
        end

        ##
        # Compute the answer for the puzzle.
        #
        # @return [Integer] answer
        def answer
          total = 0
          sort_hands.each_with_index do |hand, index|
            total += hand.bid * (index + 1)
          end
          total
        end

        ##
        # Sort the hands.
        #
        # @return [Array<Hand>] sorted hands
        def sort_hands
          @hands.sort
        end

        protected

        ##
        # Parse the input file.
        #
        # @param file [String] file name of the input file
        def parse_file(file)
          file_contents = File.readlines(file, chomp: true)
          @hands = file_contents.map do |line|
            cards, bid = line.split
            build_hand(cards, bid.to_i)
          end
        end

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
