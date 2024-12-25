# frozen_string_literal: true

require "test_helper"
require "puzzles/2024/day04/day04"

module AdventOfCode
  module Test
    module Puzzles2024
      module Day04
        ##
        # Tests Day 4 (2024) - Part 1
        class Part1Test < Minitest::Test
          def setup
            # Do nothing
          end

          def teardown
            # Do nothing
          end

          def test_part1_answer_test_set
            input_file = "#{File.dirname(__FILE__)}/test_data.txt"
            puzzle = AdventOfCode::Puzzles2024::Day04::Part1.new(file: input_file)

            assert_equal 18, puzzle.answer
          end

          def test_part1_answer_real_set
            puzzle = AdventOfCode::Puzzles2024::Day04::Part1.new

            assert_equal 2_557, puzzle.answer
          end
        end

        ##
        # Tests Day 4 (2024) - Part 2
        class Part2Test < Minitest::Test
          def setup
            # Do nothing
          end

          def teardown
            # Do nothing
          end

          def test_part2_answer_test_set
            input_file = "#{File.dirname(__FILE__)}/test_data.txt"
            puzzle = AdventOfCode::Puzzles2024::Day04::Part2.new(file: input_file)

            assert_equal 9, puzzle.answer
          end

          def test_part2_answer_real_set
            puzzle = AdventOfCode::Puzzles2024::Day04::Part2.new

            assert_equal 1_854, puzzle.answer
          end
        end
      end
    end
  end
end
