# frozen_string_literal: true

require_relative "converter"
require_relative "relation"

module AdventOfCode
  module Puzzles2023
    module Day05
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
    end
  end
end
