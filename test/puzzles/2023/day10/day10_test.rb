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

          def test_answer_test_data_set3
            input_file = "#{File.dirname(__FILE__)}/test_data_set3.txt"
            puzzle = AdventOfCode::Puzzles2023::Day10::Part1.new(file: input_file)

            assert_equal 23, puzzle.answer
          end

          def test_answer_test_data_set4
            input_file = "#{File.dirname(__FILE__)}/test_data_set4.txt"
            puzzle = AdventOfCode::Puzzles2023::Day10::Part1.new(file: input_file)

            assert_equal 70, puzzle.answer
          end

          def test_answer_test_data_set5
            input_file = "#{File.dirname(__FILE__)}/test_data_set5.txt"
            puzzle = AdventOfCode::Puzzles2023::Day10::Part1.new(file: input_file)

            assert_equal 80, puzzle.answer
          end

          def test_answer_input_set
            puzzle = AdventOfCode::Puzzles2023::Day10::Part1.new

            assert_equal 7_093, puzzle.answer
          end
        end

        # Tests Day 10 - Part 2
        class Part2Test < Minitest::Test
          def setup
            # Do nothing
          end

          def teardown
            # Do nothing
          end

          def test_answer_test_data_set3
            input_file = "#{File.dirname(__FILE__)}/test_data_set3.txt"
            puzzle = AdventOfCode::Puzzles2023::Day10::Part2.new(file: input_file)

            assert_equal 4, puzzle.answer
          end

          def test_answer_test_data_set4
            input_file = "#{File.dirname(__FILE__)}/test_data_set4.txt"
            puzzle = AdventOfCode::Puzzles2023::Day10::Part2.new(file: input_file)

            assert_equal 8, puzzle.answer
          end

          def test_answer_test_data_set5
            input_file = "#{File.dirname(__FILE__)}/test_data_set5.txt"
            puzzle = AdventOfCode::Puzzles2023::Day10::Part2.new(file: input_file)

            assert_equal 10, puzzle.answer
          end

          def test_answer_input_set
            skip "Takes too long to run" unless ENV.fetch("RUN_SLOW_TESTS", 0).to_i == 1

            puzzle = AdventOfCode::Puzzles2023::Day10::Part2.new

            assert_equal 407, puzzle.answer
          end
        end
      end
    end
  end
end
