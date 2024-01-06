# frozen_string_literal: true

require "test_helper"
require "puzzles/2023/day10/day10"

module AdventOfCode
  module Test
    module Puzzles2023
      module Day10
        # Tests Day 10 - Part 1
        class Part1Test < Minitest::Test
          def setup
            # Do nothing
          end

          def teardown
            # Do nothing
          end

          def test_answer_test_data_set1
            input_file = "#{File.dirname(__FILE__)}/test_data_set1.txt"
            puzzle = AdventOfCode::Puzzles2023::Day10::Part1.new(file: input_file)

            assert_equal 4, puzzle.answer
          end

          def test_answer_test_data_set2
            input_file = "#{File.dirname(__FILE__)}/test_data_set2.txt"
            puzzle = AdventOfCode::Puzzles2023::Day10::Part1.new(file: input_file)

            assert_equal 8, puzzle.answer
          end

          def test_answer_input_set
            puzzle = AdventOfCode::Puzzles2023::Day10::Part1.new

            assert_equal 7_093, puzzle.answer
          end
        end
      end
    end
  end
end
