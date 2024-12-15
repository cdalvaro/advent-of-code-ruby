# frozen_string_literal: true

module AdventOfCode
  module Puzzles2024
    module Day02
      ##
      # Class for solving Day 2 (2024) - Part 1 puzzle
      class Part1
        ##
        # @return [Array<Report>] list of reports
        attr_reader :reports

        ##
        # @param file [String|nil] file with puzzle input
        def initialize(file: nil)
          file ||= "#{File.dirname(__FILE__)}/input.txt"
          init_reports File.readlines(file, chomp: true)
        end

        ##
        # Compute the answer for the puzzle.
        # The answer is the number of safe reports.
        #
        # @return [Integer] answer for the puzzle
        def answer
          reports.count(&:safe?)
        end

        protected

        ##
        # Initialize the reports from the file contents.
        def init_reports(file_contents)
          @reports = file_contents.map { |line| Report.new(line) }
        end
      end
    end
  end
end
