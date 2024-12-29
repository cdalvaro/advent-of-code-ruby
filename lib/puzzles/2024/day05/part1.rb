# frozen_string_literal: true

require_relative "update_manager"

module AdventOfCode
  module Puzzles2024
    module Day05
      ##
      # Class for solving Day 5 (2024) - Part 1 puzzle
      class Part1
        ##
        # @return [UpdateManager] The update manager
        attr_reader :update_manager

        ##
        # @return [Array<Array<Integer>>] The updates
        attr_reader :updates

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
          valid_updates.sum { |update| middle_value(update) }
        end

        protected

        ##
        # Initialize the class' contents from the file contents.
        def init_contents(file_contents)
          break_index = file_contents.find_index(&:empty?)
          @update_manager = UpdateManager.new(file_contents[...break_index] || [])
          @updates = file_contents[break_index + 1..].map { |update| update.split(",").map(&:to_i) }
        end

        ##
        # Get the valid updates
        # @return [Array<Array<Integer>>] The valid updates
        def valid_updates
          @updates.select { |update| update_manager.valid?(update:) }
        end

        ##
        # Return the middle value of the update
        # @param update [Array<Integer>] The update
        # @return [Integer] The middle value
        def middle_value(update)
          update[(update.length / 2).floor]
        end
      end
    end
  end
end
