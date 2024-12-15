# frozen_string_literal: true

require_relative "part1"

module AdventOfCode
  module Puzzles2024
    module Day02
      ##
      # Class for solving Day 2 (2024) - Part 2 puzzle
      class Part2 < Part1
        protected

        ##
        # Initialize the reports from the file contents.
        def init_reports(file_contents)
          @reports = file_contents.map { |line| Report.new(line, tolerance: 1) }
        end
      end
    end
  end
end
