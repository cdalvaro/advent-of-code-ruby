# frozen_string_literal: true

module AdventOfCode
  module Puzzles2024
    module Day03
      ##
      # Class for solving Day 3 (2024) - Part 1 puzzle
      class Part1
        ##
        # The program memory
        # @return [String] the memory
        attr_reader :memory

        ##
        # @param file [String|nil] file with puzzle input
        def initialize(file: nil)
          file ||= "#{File.dirname(__FILE__)}/input.txt"
          init_contents File.readlines(file, chomp: true)
        end

        ##
        # Compute the answer for the puzzle.
        # @return [Integer] answer for the puzzle
        def answer
          ops = find_valid_ops
          compute_ops(ops)
        end

        protected

        ##
        # Initialize the class' contents from the file contents.
        def init_contents(file_contents)
          @memory = file_contents.join
        end

        ##
        # Find all valid operations in the memory
        # @return [Array<String>] the valid operations
        def find_valid_ops
          matches = memory.scan(%r{mul\(\d{1,3},\d{1,3}\)})
          matches.map(&:to_s)
        end

        ##
        # Sum the results of all operations
        # @param ops [Array<String>] the operations to sum
        # @return [Integer] the sum of all operations
        def compute_ops(ops)
          result = 0
          ops.each do |op|
            result += ::Regexp.last_match(1).to_i * ::Regexp.last_match(2).to_i if op =~ %r{(\d+),(\d+)}
          end

          result
        end
      end
    end
  end
end
