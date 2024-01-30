# frozen_string_literal: true

module AdventOfCode
  module Puzzles2023
    module Day11
      ##
      # Class for solving Day 11 - Part 1 puzzle
      class Part1
        ##
        # @param file [String] The input file
        def initialize(file: nil)
          file ||= "#{File.dirname(__FILE__)}/input.txt"
          parse_file(file)
        end

        ##
        # Get the sum of the minimum space between galaxies.
        #
        # @return [Integer] The sum of the space between galaxies
        def answer
          galaxies = find_galaxies
          pairs = make_pairs(galaxies.size)
          get_distances(pairs, galaxies).sum
        end

        protected

        ##
        # The symbol for a galaxy.
        # @return [Symbol] The symbol for a galaxy
        GALAXY_SYMBOL = :"#"

        ##
        # The space.
        # @return [Array<Array<Symbol>>] The space
        attr_reader :space

        ##
        # Parse the input file.
        #
        # @param file [String] The input file
        def parse_file(file)
          data = []
          File.readlines(file, chomp: true).each do |line|
            data << line.chars.map(&:to_sym)
          end

          @space = expand_space(data)
        end

        ##
        # Expand all empty space in the data.
        #
        # @param data [Array<Array<Symbol>>] The data
        #
        # @return [Array<Array<Symbol>>] The expanded data
        def expand_space(data)
          data = expand_empty_space(data)
          data = expand_empty_space(data.transpose)
          data.transpose
        end

        ##
        # Find all of the galaxies in the space.
        #
        # @return [Array<Array<Integer>>] The galaxies
        def find_galaxies
          galaxies = []
          space.each_with_index do |row, row_id|
            row.each_with_index do |cell, col_id|
              galaxies << [row_id, col_id] if cell == GALAXY_SYMBOL
            end
          end
          galaxies
        end

        ##
        # Make all of the pairs of galaxies.
        #
        # @param number_galaxies [Integer] The number of galaxies
        #
        # @return [Array<Array<Integer>>] The pairs of galaxies
        def make_pairs(number_galaxies)
          (0...number_galaxies).to_a.combination(2).to_a
        end

        ##
        # Get the distances between all of the pairs of galaxies.
        #
        # @param pairs [Array<Array<Integer>>] The pairs of galaxies
        # @param galaxies [Array<Array<Integer>>] The galaxies
        #
        # @return [Array<Integer>] The distances
        def get_distances(pairs, galaxies)
          pairs.map do |pair|
            get_distance(galaxies[pair[0]], galaxies[pair[1]])
          end
        end

        ##
        # Get the distance between two galaxies.
        #
        # @param galaxy1 [Array<Integer>] The first galaxy
        # @param galaxy2 [Array<Integer>] The second galaxy
        #
        # @return [Integer] The distance between the two galaxies
        def get_distance(galaxy1, galaxy2)
          (galaxy2[0] - galaxy1[0]).abs + (galaxy2[1] - galaxy1[1]).abs
        end

        private

        ##
        # Expand all empty rows in the data.
        #
        # @param data [Array<Array<Symbol>>] The data
        #
        # @return [Array<Array<Symbol>>] The expanded data
        def expand_empty_space(data)
          new_data = []
          data.each do |row|
            new_data << row
            new_data << row unless row.include?(GALAXY_SYMBOL)
          end
          new_data
        end
      end
    end
  end
end
