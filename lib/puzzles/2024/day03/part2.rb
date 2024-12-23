# frozen_string_literal: true

require_relative "part1"

module AdventOfCode
  module Puzzles2024
    module Day03
      ##
      # Class for solving Day 3 (2024) - Part 2 puzzle
      class Part2 < Part1
        protected

        ##
        # Find all valid operations in the memory
        # @return [Array<String>] the valid operations
        def find_valid_ops
          matches = memory.scan(%r{mul\(\d{1,3},\d{1,3}\)|do(?:n't)?\(\)})
          filter_ops matches.map(&:to_s)
        end

        ##
        # Filter valid operations regarding the enabled flag,
        # which is set by the do() and don't() operations.
        # @param ops [Array<String>] the operations to filter
        def filter_ops(ops)
          valid_ops = []
          enabled = true
          ops.each do |op|
            if op == "do()"
              enabled = true
              next
            elsif op == "don't()"
              enabled = false
              next
            end

            valid_ops << op if enabled
          end
          valid_ops
        end
      end
    end
  end
end
