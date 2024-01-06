# frozen_string_literal: true

require_relative "movement"
require_relative "pipe"

module AdventOfCode
  module Puzzles2023
    module Day10
      ##
      # Class for solving Day 10 - Part 1 puzzle
      class Part1
        ##
        # @param file [String] The input file
        def initialize(file: nil)
          file ||= "#{File.dirname(__FILE__)}/input.txt"
          parse_file(file)
        end

        ##
        # Get the number of steps to the furthest pipe.
        #
        # @return [Integer] The number of steps to the furthest pipe
        def answer
          total_steps = find_path.length
          if (total_steps % 2).zero?
            total_steps / 2
          else
            (total_steps / 2).floor + 1
          end
        end

        protected

        ##
        # A sketch of all of the surface pipes.
        # @return [Array<Array<Symbol>>] A sketch of all of the surface pipes
        attr_reader :data

        ##
        # Parse the input file.
        # @param file [String] The input file
        def parse_file(file)
          @data = File.readlines(file).map { |line| line.chars.map(&:to_sym) }
        end

        ##
        # Find the pipe with the :S symbol, and replace it with the real pipe.
        #
        # @return [Pipe] The real pipe
        def find_starting_pipe
          row = column = nil
          data.each_with_index do |line, row_index|
            line.each_with_index do |char, column_index|
              next unless char == :S

              row = row_index
              column = column_index
              break
            end
            break if row && column
          end

          replace_s_with_real_pipe(s_pipe: Pipe.new(sym: :S, pos: [row, column]))
        end

        ##
        # Replace the :S pipe with the real pipe.
        #
        # @param s_pipe [Pipe] The :S pipe
        #
        # @return [Pipe] The real pipe
        def replace_s_with_real_pipe(s_pipe:)
          # S neighbors
          directions = %i[up down left right]
          neighbor_pipes = directions.to_h { |dir| [dir, next_pipe(from: s_pipe, direction: dir)] }
                                     .compact

          # Find pipes that connects with two neighbors
          pipes = %w[| - L J 7 F].map { |sym| Pipe.new(sym: sym.to_sym, pos: s_pipe.pos) }
          pipes.select! do |pipe|
            connections = neighbor_pipes.filter { |direction, neighbour| pipe.can_connect?(to: neighbour, direction:) }
            connections.size == 2
          end

          pipes[0]
        end

        ##
        # Find the closed path.
        #
        # @return [Array<Pipe>] The closed path
        def find_path
          path = []
          pipe = find_starting_pipe
          path << pipe
          previous = pipe
          loop do
            new_pipe = find_next_pipe(from: pipe, previous:)
            break if new_pipe.sym == :S

            path << new_pipe
            previous = pipe
            pipe = new_pipe
          end
          path
        end

        ##
        # Get the next pipe from the given pipe in the given direction.
        #
        # @param from [Pipe] The pipe to start from
        # @param direction [Symbol] The direction to go
        #
        # @return [Pipe] The next pipe
        def next_pipe(from:, direction:)
          movement = case direction
                     when :up
                       Movement::GO_UP
                     when :down
                       Movement::GO_DOWN
                     when :right
                       Movement::GO_RIGHT
                     else
                       Movement::GO_LEFT
                     end

          pos = movement.apply(to: from.pos)
          return unless valid_pos?(pos)

          sym = data[pos[0]][pos[1]]
          pipe = Pipe.new(sym:, pos:)
          return unless from.can_connect?(to: pipe, direction:)

          pipe
        end

        ##
        # Check whether the given position is inside the bounds of the data.
        #
        # @param pos [Array<Integer>] The position to check
        #
        # @return [Boolean] True if the position is inside the bounds of the data
        def valid_pos?(pos)
          return false unless pos[0].between?(0, data.size - 1)
          return false unless pos[1].between?(0, data[pos[0]].size - 1)

          true
        end

        ##
        # Find the next pipe that connects to the current pipe.
        #
        # @param from [Pipe] The current pipe
        # @param previous [Pipe] The previous pipe (to avoid going back)
        #
        # @return [Pipe] The next pipe
        def find_next_pipe(from:, previous:) # rubocop:disable Metrics/CyclomaticComplexity
          # Can go up?
          if (new_pipe = next_pipe(from:, direction: :up)) && new_pipe != previous
            return new_pipe
          end

          # Can go right?
          if (new_pipe = next_pipe(from:, direction: :right)) && new_pipe != previous
            return new_pipe
          end

          # Can go down?
          if (new_pipe = next_pipe(from:, direction: :down)) && new_pipe != previous
            return new_pipe
          end

          # Must be left
          new_pipe = next_pipe(from:, direction: :left)
          raise "No pipe found" unless new_pipe

          new_pipe
        end
      end
    end
  end
end
