# frozen_string_literal: true

require "test_helper"
require "puzzles/2024/day01/day01"

module AdventOfCode
  module Test
    module Puzzles2024
      module Day01
        ##
        # Tests Day 1 - Part 1
        class Part1Test < Minitest::Test
          def setup
            # Do nothing
          end

          def teardown
            # Do nothing
          end

          def test_distances_test_set
            input_file = "#{File.dirname(__FILE__)}/test_data.txt"
            puzzle = AdventOfCode::Puzzles2024::Day01::Part1.new(file: input_file)

            assert_equal [2, 1, 0, 1, 2, 5], puzzle.distances
          end

          def test_answer_test_set
            input_file = "#{File.dirname(__FILE__)}/test_data.txt"
            puzzle = AdventOfCode::Puzzles2024::Day01::Part1.new(file: input_file)

            assert_equal 11, puzzle.answer
          end

          def test_answer_real_set
            puzzle = AdventOfCode::Puzzles2024::Day01::Part1.new

            assert_equal 1_222_801, puzzle.answer
          end
        end

        ##
        # Tests Day 1 - Part 2
        class Part2Test < Minitest::Test
          def setup
            # Do nothing
          end

          def teardown
            # Do nothing
          end

          def test_similarity_scores_test_set
            input_file = "#{File.dirname(__FILE__)}/test_data.txt"
            puzzle = AdventOfCode::Puzzles2024::Day01::Part2.new(file: input_file)

            assert_equal [9, 4, 0, 0, 9, 9], puzzle.similarity_scores
          end

          def test_answer_test_set
            input_file = "#{File.dirname(__FILE__)}/test_data.txt"
            puzzle = AdventOfCode::Puzzles2024::Day01::Part2.new(file: input_file)

            assert_equal 31, puzzle.answer
          end

          def test_answer_real_set
            puzzle = AdventOfCode::Puzzles2024::Day01::Part2.new

            assert_equal 22_545_250, puzzle.answer
          end
        end
      end
    end
  end
end
