# frozen_string_literal: true

require "test_helper"
require "puzzles/2023/day09/day09"

module AdventOfCode
  module Test
    module Puzzles2023
      module Day09
        # Tests Day 9 - Part 1
        class Part1Test < Minitest::Test
          def setup
            # Do nothing
          end

          def teardown
            # Do nothing
          end

          def test_predict_all_features
            input_file = "#{File.dirname(__FILE__)}/test_data.txt"
            puzzle = AdventOfCode::Puzzles2023::Day09::Part1.new(file: input_file)

            puzzle.predict_all_features

            assert_equal [18, 28, 68], puzzle.oasis.report.map(&:predicted_value)
          end

          def test_answer_test_data_set
            input_file = "#{File.dirname(__FILE__)}/test_data.txt"
            puzzle = AdventOfCode::Puzzles2023::Day09::Part1.new(file: input_file)

            assert_equal 114, puzzle.answer
          end

          def test_answer_input_set
            puzzle = AdventOfCode::Puzzles2023::Day09::Part1.new

            assert_equal 1_762_065_988, puzzle.answer
          end
        end

        ##
        # Tests Day 9 - Part 2
        class Part2Test < Minitest::Test
          def setup
            # Do nothing
          end

          def teardown
            # Do nothing
          end

          def test_predict_all_features
            input_file = "#{File.dirname(__FILE__)}/test_data.txt"
            puzzle = AdventOfCode::Puzzles2023::Day09::Part2.new(file: input_file)

            puzzle.predict_all_features

            assert_equal [-3, 0, 5], puzzle.oasis.report.map(&:predicted_value)
          end

          def test_answer_test_data_set
            input_file = "#{File.dirname(__FILE__)}/test_data.txt"
            puzzle = AdventOfCode::Puzzles2023::Day09::Part2.new(file: input_file)

            assert_equal 2, puzzle.answer
          end

          def test_answer_input_set
            puzzle = AdventOfCode::Puzzles2023::Day09::Part2.new

            assert_equal 1_066, puzzle.answer
          end
        end
      end
    end
  end
end
