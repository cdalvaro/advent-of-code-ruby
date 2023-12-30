# frozen_string_literal: true

require_relative "part1"

module AdventOfCode
  module Puzzles2023
    module Day01
      ##
      # Class for solving Day 1 - Part 2 puzzle
      class Part2 < Part1
        protected

        ##
        # Helper constant for translating word numbers to digits.
        # @return [Hash<Symbol, Integer>] word numbers to digits
        TRANSLATIONS = %i[one two three four five six seven eight nine].zip(1..9).to_h.freeze

        ##
        # Find and return the first number on a line, whether is digit or word.
        #
        # @param line [String] line to search
        #
        # @return [Integer] first number found
        def find_first_number(line)
          # Find first word number in line
          #   1. Compute the index for each possible number
          #   2. Remove nil values and swap keys and values
          #   3. Find the minimum index, line length if no word number is found
          indexes = TRANSLATIONS.to_h { |word, number| [number, line.index(word.to_s)] }
          indexes = indexes.compact.invert
          word_index = indexes.keys.min || line.length

          # Find first digit number in line, line length if no digit number is found
          digit_index = line.index(%r{\d}) || line.length

          # Select the number with the minimum index
          word_index < digit_index ? indexes[word_index] : line[digit_index, 1].to_i
        end

        ##
        # Find and return the last number on a line, whether is digit or word.
        #
        # @param line [String] line to search
        #
        # @return [Integer] last number found
        def find_last_number(line)
          # Find first word number in line
          #   1. Compute the index for each possible number
          #   2. Remove nil values and swap keys and values
          #   3. Find the maximum index, -1 if no word number is found
          indexes = TRANSLATIONS.to_h { |word, number| [number, line.rindex(word.to_s)] }
          indexes = indexes.compact.invert
          word_index = indexes.keys.max || -1

          # Find last digit number in line, -1 if no digit number is found
          digit_index = line.rindex(%r{\d}) || -1

          # Select the number with the maximum index
          word_index > digit_index ? indexes[word_index] : line[digit_index, 1].to_i
        end
      end
    end
  end
end
