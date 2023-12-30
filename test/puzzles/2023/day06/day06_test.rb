# frozen_string_literal: true

require "test_helper"
require "puzzles/2023/day06"

module AdventOfCode
  module Test
    module Puzzles2023
      module Day06
        ##
        # Tests Day 6 - Part 1
        class Part1Test < Minitest::Test
          def setup
            # Do nothing
          end

          def teardown
            # Do nothing
          end

          def test_find_time_ranges_test_data_set
            input_file = "#{File.dirname(__FILE__)}/test_data.txt"
            puzzle = AdventOfCode::Puzzles2023::Day06::Part1.new(file: input_file)

            assert_equal [2..5, 4..11, 11..19], puzzle.find_time_ranges
          end

          def test_answer_test_data_set
            input_file = "#{File.dirname(__FILE__)}/test_data.txt"
            puzzle = AdventOfCode::Puzzles2023::Day06::Part1.new(file: input_file)

            assert_equal 288, puzzle.answer
          end

          def test_answer_input_set
            input_file = "#{File.dirname(__FILE__)}/input.txt"
            puzzle = AdventOfCode::Puzzles2023::Day06::Part1.new(file: input_file)

            assert_equal 2_756_160, puzzle.answer
          end
        end

        ##
        # Tests Day 6 - Part 2
        class Part2Test < Minitest::Test
          def setup
            # Do nothing
          end

          def teardown
            # Do nothing
          end

          def test_answer_test_data_set
            input_file = "#{File.dirname(__FILE__)}/test_data.txt"
            puzzle = AdventOfCode::Puzzles2023::Day06::Part2.new(file: input_file)

            assert_equal 71_503, puzzle.answer
          end

          def test_answer_input_set
            input_file = "#{File.dirname(__FILE__)}/input.txt"
            puzzle = AdventOfCode::Puzzles2023::Day06::Part2.new(file: input_file)

            assert_equal 34_788_142, puzzle.answer
          end
        end
      end
    end
  end
end
