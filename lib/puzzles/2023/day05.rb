# frozen_string_literal: true

module AdventOfCode
  module Puzzles2023
    ##
    # Advent of Code 2023 - Day 5
    # https://adventofcode.com/2023/day/4
    module Day05
      class Converter
        attr_reader :source, :destination, :relations

        def initialize(source:, destination:, relations:)
          @source = source
          @destination = destination
          @relations = relations
        end

        def convert(value:)
          # Find value in maps
          relations.each do |relation|
            # Is value in source range?
            if relation[:source].include?(value)
              # Then, convert to destination range
              return relation[:destination].begin + (value - relation[:source].begin)
            end
          end
          value
        end
      end

      class Almanac
        attr_reader :converters

        def initialize(file:, reverse: false)
          @targets = reverse ? %i[destination source] : %i[source destination]
          parse_file(file)
        end

        def convert(value:, from:, to:)
          converter = converters[from]
          value = converter.convert(value:)
          return value if converter.destination == to

          convert(value:, from: converter.destination, to:)
        end

        protected

        attr_accessor :targets

        def parse_file(file)
          file_contents = File.readlines(file, chomp: true)

          # Remove seeds line
          file_contents.shift

          parse_maps(file_contents)
        end

        def parse_header(line)
          match = line.match(%r{(?<source>\w+)-to-(?<destination>\w+) map:$})
          return nil if match.nil?

          targets.map { |target| match[target].to_sym }
        end

        def parse_map(line)
          destination_start, source_start, length = line.split.map(&:to_i)
          {
            targets.first => source_start...source_start + length,
            targets.last => destination_start...destination_start + length
          }
        end

        def parse_maps(lines)
          source = nil
          destination = nil
          relations = []
          @converters = {}

          # Append empty line to force save last conversion
          lines << ""

          lines.each do |line|
            if line.empty?
              # Save conversion if relations
              @converters[source] = Converter.new(source:, destination:, relations:) unless source.nil?

              # Reset variables
              source = nil
              destination = nil
              relations = []
            elsif (header = parse_header(line))
              # Is header
              source, destination = header
            else
              # Is a map
              relations << parse_map(line)
            end
          end
        end
      end

      ##
      # Class for solving Day 5 - Part 1 puzzle
      class Part1
        attr_reader :almanac, :seeds

        def initialize(file:)
          seeds_line = File.readlines(file, chomp: true).first || ""
          parse_seeds(seeds_line)
          parse_almanac(file:)
        end

        def answer
          locations = seeds.map do |seed|
            almanac.convert(value: seed, from: :seed, to: :location)
          end
          locations.min
        end

        protected

        def parse_almanac(file:)
          @almanac = Almanac.new(file:)
        end

        def parse_seeds(line)
          match = line.match(%r{^seeds: (?<seeds>[0-9 ]+)$})
          raise "Invalid seeds line: #{line}" if match.nil?

          @seeds = match[:seeds].split.map(&:to_i)
        end
      end

      ##
      # Class for solving Day 5 - Part 2 puzzle
      class Part2 < Part1
        def answer
          location = 0
          loop do
            seed = almanac.convert(value: location, from: :location, to: :seed)
            return location if valid_seed?(value: seed)

            location += 1
          end
        end

        protected

        def parse_almanac(file:)
          @almanac = Almanac.new(file:, reverse: true)
        end

        def parse_seeds(line)
          match = line.match(%r{^seeds: \b\d+\s+\d+\b})
          raise "Invalid seeds line: #{line}" if match.nil?

          @seeds = []

          line = line.gsub(%r{seeds:\s+}, "")
          line.scan(%r{\b(?<start>\d+)\s+(?<length>\d+)\b}).each do |start, length|
            from = start.to_i
            to = from + length.to_i
            @seeds << (from...to)
          end
        end

        def valid_seed?(value:)
          seeds.any? { |seed_range| seed_range.include?(value) }
        end
      end
    end
  end
end
