# frozen_string_literal: true

module AdventOfCode
  module Puzzles2023
    ##
    # Advent of Code 2023 - Day 5
    # https://adventofcode.com/2023/day/5
    module Day05
      ##
      # Class for representing a relation.
      class Relation
        ##
        # @param source [Range] range of source values
        # @param destination [Range] range of destination values
        def initialize(source:, destination:)
          @source = source
          @destination = destination
        end

        ##
        # Convert a source value to destination value.
        # If value is not in source range, return nil.
        #
        # @param value [Integer] source value to convert
        #
        # @return [Integer, nil] destination value or nil if value is not in source range
        def convert(value:)
          # Is value in source range?
          return unless @source.include?(value)

          # Then, convert to destination range
          @destination.begin + (value - @source.begin)
        end
      end

      ##
      # Class for converting values from source to destination.
      class Converter
        attr_reader :source, :destination

        ##
        # @param source [Symbol] source of the conversion
        # @param destination [Symbol] destination of the conversion
        # @param relations [Array<Relation>] array of relations
        def initialize(source:, destination:, relations:)
          @source = source
          @destination = destination
          @relations = relations
        end

        ##
        # Convert a value from source to destination.
        #
        # @param value [Integer] value to convert
        #
        # @return [Integer] converted value
        def convert(value:)
          # Find value in maps
          @relations.each do |relation|
            if (result = relation.convert(value:))
              return result
            end
          end
          value
        end
      end

      ##
      # Class for representing an almanac.
      # An almanac is a collection of converters.
      class Almanac
        ##
        # @param file [String] path to input file
        # @param reverse [Boolean] if true, the conversion is done from destination to source
        def initialize(file:, reverse: false)
          @targets = reverse ? %i[destination source] : %i[source destination]
          parse_file(file)
        end

        ##
        # Convert a source value to a destination.
        #
        # @param value [Integer] value to convert
        # @param from [Symbol] source of the conversion
        # @param to [Symbol] destination of the conversion
        #
        # @return [Integer] converted value
        def convert(value:, from:, to:)
          converter = converters[from]
          value = converter.convert(value:)
          return value if converter.destination == to

          convert(value:, from: converter.destination, to:)
        end

        protected

        ##
        # Hash of converters.
        # Keys are source symbols, values are Converter objects.
        #
        # @return [Hash<Symbol, Converter>] hash of converters
        attr_reader :converters

        ##
        # Contains symbols: :source, :destination,
        # ordered by the direction of the conversion.
        #
        # @return [Array<Symbol>] array of symbols
        attr_reader :targets

        ##
        # Build the converters from the file.
        #
        # @param file [String] path to input file
        def parse_file(file)
          file_contents = File.readlines(file, chomp: true)

          # Remove seeds line
          file_contents.shift

          parse_maps(file_contents)
        end

        ##
        # Parse a header line.
        # A header line is a line that contains the source and destination of the conversion.
        # It is in the form: source-to-destination map:
        # If line is not a header line, return nil.
        #
        # @param line [String] line to parse
        #
        # @return [Array<Symbol>, nil] array of symbols or nil if line is not a header line
        def parse_header(line)
          match = line.match(%r{(?<source>\w+)-to-(?<destination>\w+) map:$})
          return if match.nil?

          targets.map { |target| match[target] }.map(&:to_sym)
        end

        ##
        # Parse a map line.
        #
        # @param line [String] line to parse
        #
        # @return [Relation] relation
        def parse_map(line)
          destination_start, source_start, length = line.split.map(&:to_i)
          relation = {
            targets.first => source_start...source_start + length,
            targets.last => destination_start...destination_start + length
          }
          Relation.new(**relation)
        end

        ##
        # Parse the maps from the file contents.
        # A map is a set of relations.
        #
        # @param lines [Array<String>] array of lines
        def parse_maps(lines)
          source = nil
          destination = nil
          relations = []
          @converters = {}

          # Append empty line to force save last conversion
          lines << ""

          lines.each do |line|
            if line.empty?
              # Save conversion if source
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
        attr_reader :seeds

        ##
        # @param file [String] path to input file
        def initialize(file:)
          seeds_line = File.readlines(file, chomp: true).first || ""
          parse_seeds(seeds_line)
          build_almanac(file:)
        end

        ##
        # Get the minimum location among the seeds.
        #
        # @return [Integer, nil] minimum location
        def answer
          locations = seeds.map do |seed|
            almanac.convert(value: seed, from: :seed, to: :location)
          end
          locations.min
        end

        protected

        attr_reader :almanac

        ##
        # Build the almanac from the file.
        #
        # @param file [String] path to input file
        def build_almanac(file:)
          @almanac = Almanac.new(file:)
        end

        ##
        # Parse the seeds from the seeds line.
        # Seeds are in the form: seeds: <seed1> <seed2> ...
        #
        # @param line [String] seeds line
        #
        # @raise [RuntimeError] if seeds line is invalid
        def parse_seeds(line)
          match = line.match(%r{^seeds: (?<seeds>[0-9 ]+)$})
          raise "Invalid seeds line: #{line}" if match.nil?

          @seeds = match[:seeds].split.map(&:to_i) || []
        end
      end

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
