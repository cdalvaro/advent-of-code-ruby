# frozen_string_literal: true

module AdventOfCode
  module Puzzles2023
    module Day08
      ##
      # Class for solving Day 8 - Part 1 puzzle
      class Part1
        ##
        # Array of instructions
        # @return [Array<Symbol>] movement instructions
        attr_reader :instructions

        ##
        # Hash of nodes
        # @return [Hash<Symbol, Hash<Symbol, Symbol>>] nodes
        attr_reader :nodes

        ##
        # @param file [String] path to input file
        def initialize(file: nil)
          file ||= "#{File.dirname(__FILE__)}/input.txt"
          parse_file(file)
        end

        ##
        # Get the number of steps to get from :AAA to :ZZZ
        #
        # @return [Integer] number of steps
        def answer
          find_path.size - 1
        end

        ##
        # Find the path from :AAA to :ZZZ
        #
        # @return [Array<Symbol>] path
        def find_path
          path = [:AAA]
          instructions.cycle do |instruction|
            node = nodes[path.last][instruction]
            path << node
            break if node == :ZZZ
          end
          path
        end

        protected

        ##
        # Parse the input file and set the instructions and nodes
        # attributes.
        #
        # @param file [String] path to input file
        def parse_file(file)
          file_contents = File.readlines(file, chomp: true)
          file_contents.reject!(&:empty?)

          # Instructions
          first_line = file_contents.shift || ""
          @instructions = first_line.chars.map(&:to_sym)

          # Nodes
          @nodes = file_contents.to_h do |line|
            node, elements = line.split(" = ")
            match = elements.match(%r{\((?<left>\w+), (?<right>\w+)\)})
            [node.to_sym, { L: match[:left]&.to_sym, R: match[:right]&.to_sym }]
          end
        end
      end
    end
  end
end
