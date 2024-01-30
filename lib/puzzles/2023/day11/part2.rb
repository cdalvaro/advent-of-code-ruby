# frozen_string_literal: true

require_relative "part1"

module AdventOfCode
  module Puzzles2023
    module Day11
      ##
      # Class for solving Day 11 - Part 2 puzzle
      class Part2 < Part1
        ##
        # @param file [String] The input file
        # @param expansion_rate [Integer] The expansion rate
        def initialize(file: nil, expansion_rate: Integer(1E06))
          super(file:)
          @expansion_rate = expansion_rate
        end

        protected

        ##
        # The expansion rate for empty space.
        # @return [Integer] The expansion rate for empty space
        attr_reader :expansion_rate

        ##
        # The regions that have been expanded.
        # @return [Hash<Symbol, Set<Integer>>] The regions that have been expanded
        attr_reader :expanded_regions

        ##
        # Expand all empty space in the data.
        # This method does not change the data itself,
        # but it does keep track of the expanded regions.
        #
        # @param data [Array<Array<Symbol>>] The raw data
        #
        # @return [Array<Array<Symbol>>] The raw data
        def expand_space(data)
          @expanded_regions = { rows: Set.new, columns: Set.new }
          data.each_with_index do |row, row_id|
            expanded_regions[:rows] << row_id unless row.include?(GALAXY_SYMBOL)
          end
          data.transpose.each_with_index do |column, column_id|
            expanded_regions[:columns] << column_id unless column.include?(GALAXY_SYMBOL)
          end

          # Data remains unchanged
          data
        end

        ##
        # Get the distance between two galaxies.
        # This method takes into account the expansion rate.
        #
        # @param galaxy1 [Array<Integer>] The first galaxy
        # @param galaxy2 [Array<Integer>] The second galaxy
        #
        # @return [Integer] The distance between the two galaxies
        def get_distance(galaxy1, galaxy2)
          number_of_rows = get_1d_distance(galaxy1, galaxy2, dimension: :rows)
          number_of_columns = get_1d_distance(galaxy1, galaxy2, dimension: :columns)
          number_of_rows + number_of_columns
        end

        ##
        # Get the distance between two galaxies in one dimension.
        # This method takes into account the expansion rate.
        #
        # @param galaxy1 [Array<Integer>] The first galaxy
        # @param galaxy2 [Array<Integer>] The second galaxy
        # @param dimension [Symbol] The dimension to calculate the distance in
        #
        # @return [Integer] The distance between the two galaxies in the given dimension
        def get_1d_distance(galaxy1, galaxy2, dimension:)
          dim = dimension == :rows ? 0 : 1
          min, max = [galaxy1[dim], galaxy2[dim]].minmax
          (min...max).inject(0) do |sum, position|
            sum + (expanded_regions[dimension].include?(position) ? expansion_rate : 1)
          end
        end
      end
    end
  end
end
