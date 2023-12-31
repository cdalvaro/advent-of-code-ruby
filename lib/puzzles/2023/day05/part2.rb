# frozen_string_literal: true

require_relative "part1"
require_relative "almanac"

module AdventOfCode
  module Puzzles2023
    module Day05
      ##
      # Class for solving Day 5 - Part 2 puzzle
      class Part2 < Part1
        ##
        # Get the minimum location that is associated with a valid seed.
        #
        # @return [Integer, nil] minimum location
        def answer
          location = 0
          loop do
            seed = almanac.convert(value: location, from: :location, to: :seed)
            return location if valid_seed?(value: seed)

            location += 1
          end
        end

        protected

        ##
        # Build the almanac from the file.
        #
        # @param file [String] path to input file
        def build_almanac(file:)
          @almanac = Almanac.new(file:, reverse: true)
        end

        ##
        # Parse the seeds from the seeds line.
        # Seeds are in the form: seeds: <start> <length> <start> <length> ...
        # <start> is the first seed, <length> is the number of seeds.
        #
        # @param line [String] seeds line
        def parse_seeds(line)
          match = line.match(%r{^seeds: \b\d+\s+\d+\b})
          raise "Invalid seeds line: #{line}" if match.nil?

          @seeds = []
          line.scan(%r{\b(?<start>\d+)\s+(?<length>\d+)\b}).each do |start, length|
            from = start.to_i
            to = from + length.to_i
            @seeds << (from...to)
          end
        end

        ##
        # Check if a value is a valid seed.
        # A valid seed is a seed that is in the seeds ranges.
        #
        # @param value [Integer] value to check
        #
        # @return [Boolean] true if value is a valid seed, false otherwise
        def valid_seed?(value:)
          seeds.any? { |seed_range| seed_range.include?(value) }
        end
      end
    end
  end
end
