# frozen_string_literal: true

require_relative "part1"
require_relative "gear"

module AdventOfCode
  module Puzzles2023
    module Day03
      ##
      # Class for solving Day 3 - Part 2 puzzle
      class Part2 < Part1
        ##
        # Array of Gear objects
        # @return [Array<Gear>] array of gears
        attr_reader :gears

        ##
        # @param file [String] path to input file
        def initialize(file: nil)
          super(file:)
          @gears = find_gears
        end

        ##
        # Get the sum of the ratios of the gears.
        #
        # @return [Integer] sum of the ratios of the gears
        def answer
          gears.sum(&:ratio)
        end

        protected

        ##
        # Find the gears in the puzzle.
        #
        # @return [Array<Gear>] array of gears
        def find_gears
          gears = []
          symbols.each_with_index do |row_symbols, row_index|
            row_symbols.each do |symbol_index, symbol|
              adjacent_numbers = find_adjacent_numbers(row_index, symbol_index)
              if adjacent_numbers.length == 2
                gears << Gear.new(symbol:, index: "#{row_index}:#{symbol_index}", numbers: adjacent_numbers)
              end
            end
          end
          gears
        end

        ##
        # Find the numbers next to the given symbol.
        #
        # @param row_index [Integer] index of the row to check
        # @param symbol_index [Integer] index of the symbol to check
        #
        # @return [Array<Integer>] array of numbers next to the symbol
        def find_adjacent_numbers(row_index, symbol_index)
          # Adjacent rows
          adjacent_number_rows = adjacent_rows_range(row_index, numbers.length - 1)

          # Check numbers next to the current symbol
          adjacent_numbers = []
          adjacent_number_rows.each do |number_row_idx|
            numbers[number_row_idx].each do |number_idx, number|
              # Indexes occupied by the current number
              number_limits = number_idx - 1..number_idx + number.length
              adjacent_numbers << number.to_i if number_limits.include?(symbol_index)
            end
          end

          adjacent_numbers
        end
      end
    end
  end
end
