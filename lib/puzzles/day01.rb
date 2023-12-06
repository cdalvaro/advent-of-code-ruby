# frozen_string_literal: true

module AdventOfCode
  module Puzzles
    ##
    # Advent of Code 2023 - Day 1
    # https://adventofcode.com/2023/day/1
    module Day01
      ##
      # Class for solving Day 01 - Part 1 puzzle
      #
      # On each line, the calibration value can be found by combining
      # the first digit and the last digit (in that order) to form a
      # single two-digit number.
      class Part1
        attr_reader :file_contents

        def initialize(file:)
          @file_contents = File.readlines(file, chomp: true)
        end

        def answer
          calibration_values.sum
        end

        ##
        # Compute calibration values based on file contents.
        #
        # @return [Array<Integer>] calibration values
        def calibration_values
          @calibration_values ||= file_contents.map { |line| select_number(line) }
        end

        protected

        ##
        # Select first and last number from line.
        #
        # @param line [String] line to select numbers from
        #
        # @return [Integer] first and last number concatenated
        def select_number(line)
          first_number = find_first_number(line)
          last_number = find_last_number(line)
          "#{first_number}#{last_number}".to_i
        end

        ##
        # Find and return the first number in a line.
        #
        # @param line [String] line to search
        #
        # @return [Integer, nil] first number found
        def find_first_number(line)
          line.match(%r{^\D*(\d).*})[1]&.to_i
        end

        ##
        # Find and return the last number in a line.
        #
        # @param line [String] line to search
        #
        # @return [Integer, nil] last number found
        def find_last_number(line)
          line.match(%r{.*?(\d)\D*$})[1]&.to_i
        end
      end

      ##
      # Class for solving Day 01 - Part 2 puzzle
      #
      # It looks like some of the digits are actually spelled out with
      # letters: one, two, three, four, five, six, seven, eight, and
      # nine also count as valid "digits".
      class Part2 < Part1
        protected

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
