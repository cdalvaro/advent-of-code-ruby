# frozen_string_literal: true

require_relative "part1"

module AdventOfCode
  module Puzzles2023
    module Day08
      ##
      # Class for solving Day 8 - Part 2 puzzle
      class Part2 < Part1
        ##
        # Get the number of steps to get from :abA to :mnZ.
        #
        # @return [Integer] number of steps
        def answer
          steps_by_node = find_initial_nodes.map do |node|
            steps = 0
            instructions.cycle do |instruction|
              steps += 1
              node = nodes[node][instruction]
              break if node.end_with?("Z")
            end
            steps
          end

          # The number of steps to get from :abA to :mnZ is the least
          # common multiple of the number of steps to get from
          steps_by_node.inject(:lcm)
        end

        ##
        # Find the path from :abA to :mnZ.
        #
        # @return [Array<Array<Symbol>>] path
        def find_path
          raise NotImplementedError "To heavy to calculate"
        end

        protected

        ##
        # Find nodes that end in A.
        #
        # @return [Array<Symbol>] nodes
        def find_initial_nodes
          nodes.keys.select { |node| node.end_with?("A") }
        end
      end
    end
  end
end
