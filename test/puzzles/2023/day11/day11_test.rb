# frozen_string_literal: true

require "test_helper"
require "puzzles/2023/day11/day11"

module AdventOfCode
  module Test
    module Puzzles2023
      module Day11
        # Tests Day 11 - Part 1
        class Part1Test < Minitest::Test
          def setup
            # Do nothing
          end

          def teardown
            # Do nothing
          end

          def test_answer_test_data_set
            input_file = "#{File.dirname(__FILE__)}/test_data.txt"
            puzzle = AdventOfCode::Puzzles2023::Day11::Part1.new(file: input_file)

            assert_equal 374, puzzle.answer
          end

          def test_answer_input_set
            puzzle = AdventOfCode::Puzzles2023::Day11::Part1.new

            assert_equal 10_313_550, puzzle.answer
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

          def test_answer_test_data_set_expansion_rate2
            input_file = "#{File.dirname(__FILE__)}/test_data.txt"
            puzzle = AdventOfCode::Puzzles2023::Day11::Part2.new(file: input_file, expansion_rate: 2)

            assert_equal 374, puzzle.answer
          end

          def test_answer_test_data_set_expansion_rate10
            input_file = "#{File.dirname(__FILE__)}/test_data.txt"
            puzzle = AdventOfCode::Puzzles2023::Day11::Part2.new(file: input_file, expansion_rate: 10)

            assert_equal 1_030, puzzle.answer
          end

          def test_answer_test_data_set_expansion_rate100
            input_file = "#{File.dirname(__FILE__)}/test_data.txt"
            puzzle = AdventOfCode::Puzzles2023::Day11::Part2.new(file: input_file, expansion_rate: 100)

            assert_equal 8410, puzzle.answer
          end

          def test_answer_test_data_set_default_expansion_rate
            input_file = "#{File.dirname(__FILE__)}/test_data.txt"
            puzzle = AdventOfCode::Puzzles2023::Day11::Part2.new(file: input_file)

            assert_equal 82_000_210, puzzle.answer
          end

          def test_answer_input_set
            puzzle = AdventOfCode::Puzzles2023::Day11::Part2.new

            assert_equal 611_998_089_572, puzzle.answer
          end
        end
      end
    end
  end
end
