# frozen_string_literal: true

module AdventOfCode
  module Puzzles2023
    module Day01
      ##
      # Class for solving Day 1 - Part 1 puzzle
      class Part1
        ##
        # @param file [String] file with puzzle input
        def initialize(file: nil)
          file ||= "#{File.dirname(__FILE__)}/input.txt"
          @file_contents = File.readlines(file, chomp: true)
        end

        ##
        # Compute the answer for the puzzle.
        # The answer is the sum of all calibration values.
        #
        # @return [Integer] answer for the puzzle
        def answer
          calibration_values.sum
        end

        ##
        # Compute calibration values based on file contents.
        #
        # @return [Array<Integer>] calibration values
        def calibration_values
          @calibration_values ||= file_contents.map { |line| select_number(line) }
        end

        protected

        ##
        # @return [Array<String>] file contents
        attr_reader :file_contents

        ##
        # Select first and last number from line.
        #
        # @param line [String] line to select numbers from
        #
        # @return [Integer] first and last number concatenated
        def select_number(line)
          first_number = find_first_number(line)
          last_number = find_last_number(line)
          "#{first_number}#{last_number}".to_i
        end

        ##
        # Find and return the first number in a line.
        #
        # @param line [String] line to search
        #
        # @return [Integer, nil] first number found
        def find_first_number(line)
          line.match(%r{^\D*(\d).*})[1]&.to_i
        end

        ##
        # Find and return the last number in a line.
        #
        # @param line [String] line to search
        #
        # @return [Integer, nil] last number found
        def find_last_number(line)
          line.match(%r{.*?(\d)\D*$})[1]&.to_i
        end
      end
    end
  end
end
