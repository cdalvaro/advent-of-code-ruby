# frozen_string_literal: true

require_relative "race"

module AdventOfCode
  module Puzzles2023
    module Day06
      ##
      # Class for solving Day 6 - Part 1 puzzle
      class Part1
        ##
        # @return [Array<Race>] races to participate
        attr_reader :races

        ##
        # @param file [String] file name of the input file
        def initialize(file: nil)
          file ||= "#{File.dirname(__FILE__)}/input.txt"
          parse_file(file:)
        end

        ##
        # Get the product of the sum of the time ranges.
        #
        # @return [Integer] product of the sum of the time ranges
        def answer
          find_time_ranges.reduce(1) { |total, t_range| total * t_range.count }
        end

        ##
        # Find the winning time ranges for each reace.
        #
        # @return [Array<Range<Integer>>] the winning time ranges for each reace
        def find_time_ranges
          @races.map { |race| find_time_range(race:) }
        end

        protected

        ##
        # Parse the file contents.
        #
        # @param file [String] file name of the input file
        #
        # @raise [RuntimeError] if the file contents are not valid
        def parse_file(file:)
          file_contents = File.readlines(file, chomp: true)

          times = parse_values(file_contents, key: "Time")
          distances = parse_values(file_contents, key: "Distance")

          # Checks
          raise "Incompatible lengths between times and distances" unless distances.length == times.length

          # Build races
          @races = times.zip(distances).map { |time, distance| Race.new(time:, distance:) }
        end

        ##
        # Parse the values from the file contents for a given key.
        #
        # @param file_contents [Array<String>] array of lines
        # @param key [String] key to find
        #
        # @return [Array<Integer>] array of values
        def parse_values(file_contents, key:)
          values = file_contents.grep(%r{^#{key}:}).first
          raise "No #{key} found" unless values

          values.split[1..].map(&:to_i)
        end

        ##
        # Method to find the times that give a distance greater than the target distance.
        #
        # @param race [Race] the race to get the time range for winning
        #
        # @return [Range] the time range for winning
        def find_time_range(race:)
          xl, xh = find_race_distance_times(race:)

          # Those are the values that give a charging time to get the same target distance.
          # But we need to find the time that gives a distance greater than the target distance.
          # Since, this is a parabola, we know that the target time is contained in the range.
          # We just need to fit the boundaries to closer integers that give a greater distance.
          xl = xl.ceil
          xl += 1 unless valid_time?(race:, charging_time: xl)

          xh = xh.floor
          xh -= 1 unless valid_time?(race:, charging_time: xh)

          xl..xh
        end

        ##
        # Find the charging times that give a distance equal to the target distance.
        #
        # These are the equations of the problem:
        #
        # ```math
        # x := time charging
        # y := time moving
        # t := total time
        #   t = x + y
        #
        # v := x * 1mm/ms
        #   d = y * v
        #     = (t - x) * x
        # ```
        #
        # So, the charging times that give a distance equal to the target distance are:
        #
        # ```math
        # x^2 -tx + d = 0
        #   x = (t +/- sqrt(t^2 - 4d)) / 2
        # ```
        #
        # @param race [Race] the race parameters
        #
        # @return [Array<Float>] the charging times of the distance to beat
        def find_race_distance_times(race:)
          inner_sqrt = (race.time**2) - (4 * race.distance)
          sqrt = Math.sqrt(inner_sqrt.to_f)
          xl = (race.time - sqrt) / 2
          xh = (race.time + sqrt) / 2

          [xl, xh]
        end

        ##
        # Check if the charging time gives a distance greater than the target distance.
        #
        # @param race [Race] the race to check whether the `charging_time` is valid.
        # @param charging_time [Integer] the charging time to check
        #
        # @return [Boolean] whether the `charging_time` is valid
        def valid_time?(race:, charging_time:)
          charging_time * (race.time - charging_time) > race.distance
        end
      end
    end
  end
end
