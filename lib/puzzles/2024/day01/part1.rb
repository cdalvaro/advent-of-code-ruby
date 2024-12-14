# frozen_string_literal: true

module AdventOfCode
  module Puzzles2024
    module Day01
      ##
      # Class for solving Day 1 - Part 1 puzzle
      class Part1
        ##
        # @param file [String|nil] file with puzzle input
        def initialize(file: nil)
          file ||= "#{File.dirname(__FILE__)}/input.txt"
          init_lists File.readlines(file, chomp: true)
        end

        ##
        # Compute the answer for the puzzle.
        # The answer is the sum of all distances.
        #
        # @return [Integer] answer for the puzzle
        def answer
          distances.sum
        end

        ##
        # Compute distances based on list_a and list_b.
        #
        # @return [Array<Integer>] calibration values
        def distances
          @distances ||= list_a.sort.zip(list_b.sort).map { |a, b| (a - b).abs }
        end

        protected

        ##
        # @return [Array<String>] list of values from the first list
        attr_reader :list_a

        ##
        # @return [Array<String>] list of values from the second list
        attr_reader :list_b

        def init_lists(file_contents)
          @list_a = []
          @list_b = []
          file_contents.each do |line|
            a, b = line.split.map(&:to_i)
            @list_a << a
            @list_b << b
          end
        end
      end
    end
  end
end
