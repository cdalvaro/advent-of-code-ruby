# frozen_string_literal: true

require_relative "almanac"

module AdventOfCode
  module Puzzles2023
    module Day05
      ##
      # Class for solving Day 5 - Part 1 puzzle
      class Part1
        attr_reader :seeds

        ##
        # @param file [String] path to input file
        def initialize(file: nil)
          file ||= "#{File.dirname(__FILE__)}/input.txt"
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

          matched_seeds = match[:seeds] || ""
          @seeds = matched_seeds.split.map(&:to_i)
        end
      end
    end
  end
end
