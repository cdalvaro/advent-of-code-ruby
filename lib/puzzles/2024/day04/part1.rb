# frozen_string_literal: true

require "cdalvaro/pair"

module AdventOfCode
  module Puzzles2024
    module Day04
      ##
      # Class for solving Day 4 (2024) - Part 1 puzzle
      class Part1
        ##
        # The text where searching for the answer
        attr_reader :text

        ##
        # The height of the text
        attr_reader :height

        ##
        # The width of the text
        attr_reader :width

        ##
        # @param file [String|nil] file with puzzle input
        def initialize(file: nil)
          file ||= "#{File.dirname(__FILE__)}/input.txt"
          init_contents File.readlines(file, chomp: true)
        end

        ##
        # Compute the answer for the puzzle.
        # <Add description here>
        #
        # @return [Integer] answer for the puzzle
        def answer
          x_indexes = find_indexes_for(pattern: "X")
          x_indexes.sum { |pair| number_of_xmas_words_for_pair(pair) }
        end

        protected

        ##
        # Initialize the class' contents from the file contents.
        def init_contents(file_contents)
          @text = file_contents
          @height = text.length
          @width = text[0]&.length || 0
        end

        ##
        # Find all the indexes for the given pattern in the text
        # @return [Array<Cdalvaro::Pair>] The indexes of the pattern in the text
        def find_indexes_for(pattern:)
          indexes = []
          text.each_with_index do |line, row_idx|
            line.enum_for(:scan, pattern).map { Regexp.last_match&.begin(0) }.each do |col_idx|
              indexes << Cdalvaro::Pair.new(row_idx, col_idx)
            end
          end
          indexes
        end

        ##
        # Return the number of XMAS words for the given pair
        # @param pair [Cdalvaro::Pair] The position of the X
        # @return [Integer] The number of XMAS words
        def number_of_xmas_words_for_pair(pair)
          possible_movements(pair).inject(0) do |acc, m|
            acc + (compose_word(m.first, m.second) == "XMAS" ? 1 : 0)
          end
        end

        ##
        # Return the possible movements for the given pair
        # @param pair [Cdalvaro::Pair] The position of the X
        # @return [Array<Cdalvaro::Pair>] The possible movements
        def possible_movements(pair)
          movements = []
          movements += horizontal_movements(pair)
          movements += vertical_movements(pair)
          movements += diagonal1_movements(pair)
          movements += diagonal2_movements(pair)

          movements.select { |m| check_bounds(m.first, m.second) }
        end

        ##
        # Check if the given rows and cols are within the bounds of the text
        # @param rows [Array<Integer>] The rows
        # @param cols [Array<Integer>] The cols
        # @return [Boolean] True if the rows and cols are within the bounds
        def check_bounds(rows, cols)
          rows.min >= 0 && rows.max < height && cols.min >= 0 && cols.max < width
        end

        ##
        # Compose the word from the given rows and cols
        # @param rows [Array<Integer>] The rows
        # @param cols [Array<Integer>] The cols
        # @return [String] The composed word
        def compose_word(rows, cols)
          rows.zip(cols).map { |r, c| text[r][c] }.join
        end

        ##
        # Return the possible horizontal movements for the given pair
        # @param pair [Cdalvaro::Pair] The position of the X
        # @return [Array<Cdalvaro::Pair>] The possible movements
        def horizontal_movements(pair)
          rows = Array.new(4, pair.first)
          movements = []

          ## Left to right
          cols = (pair.second..pair.second + 3).to_a
          movements << Cdalvaro::Pair.new(rows, cols)

          ## Right to left
          cols = (pair.second - 3..pair.second).to_a.reverse
          movements << Cdalvaro::Pair.new(rows, cols)

          movements
        end

        ##
        # Return the possible vertical movements for the given pair
        # @param pair [Cdalvaro::Pair] The position of the X
        # @return [Array<Cdalvaro::Pair] The possible movements
        def vertical_movements(pair)
          cols = Array.new(4, pair.second)
          movements = []

          ## Top to bottom
          rows = (pair.first..pair.first + 3).to_a
          movements << Cdalvaro::Pair.new(rows, cols)

          ## Bottom to top
          rows = (pair.first - 3..pair.first).to_a.reverse
          movements << Cdalvaro::Pair.new(rows, cols)

          movements
        end

        ##
        # Return the possible diagonal (1) movements for the given pair
        # @param pair [Cdalvaro::Pair] The position of the X
        # @return [Array<Cdalvaro::Pair>] The possible movements
        def diagonal1_movements(pair)
          movements = []

          ## Top left to bottom right
          rows = (pair.first..pair.first + 3).to_a
          cols = (pair.second..pair.second + 3).to_a
          movements << Cdalvaro::Pair.new(rows, cols)

          ## Bottom right to top left
          rows = (pair.first - 3..pair.first).to_a.reverse
          cols = (pair.second - 3..pair.second).to_a.reverse
          movements << Cdalvaro::Pair.new(rows, cols)

          movements
        end

        ##
        # Return the possible diagonal (2) movements for the given pair
        # @param pair [Cdalvaro::Pair] The position of the X
        # @return [Array<Cdalvaro::Pair>] The possible movements
        def diagonal2_movements(pair)
          movements = []

          ## Top right to bottom left
          rows = (pair.first..pair.first + 3).to_a
          cols = (pair.second - 3..pair.second).to_a.reverse
          movements << Cdalvaro::Pair.new(rows, cols)

          ## Bottom left to top right
          rows = (pair.first - 3..pair.first).to_a.reverse
          cols = (pair.second..pair.second + 3).to_a
          movements << Cdalvaro::Pair.new(rows, cols)

          movements
        end
      end
    end
  end
end
