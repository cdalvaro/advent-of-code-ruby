# frozen_string_literal: true

require "test_helper"
require "puzzles/2024/day03/day03"

module AdventOfCode
  module Test
    module Puzzles2024
      module Day03
        ##
        # Tests Day 3 (2024) - Part 1
        class Part1Test < Minitest::Test
          def setup
            # Do nothing
          end

          def teardown
            # Do nothing
          end

          def test_part1_answer_test_set
            input_file = "#{File.dirname(__FILE__)}/test_data_part1.txt"
            puzzle = AdventOfCode::Puzzles2024::Day03::Part1.new(file: input_file)

            assert_equal 161, puzzle.answer
          end

          def test_part1_answer_real_set
            puzzle = AdventOfCode::Puzzles2024::Day03::Part1.new

            assert_equal 173_529_487, puzzle.answer
          end
        end

        ##
        # Tests Day 3 (2024) - Part 2
        class Part2Test < Minitest::Test
          def setup
            # Do nothing
          end

          def teardown
            # Do nothing
          end

          def test_part2_answer_test_set
            input_file = "#{File.dirname(__FILE__)}/test_data_part2.txt"
            puzzle = AdventOfCode::Puzzles2024::Day03::Part2.new(file: input_file)

            assert_equal 48, puzzle.answer
          end

          def test_part2_answer_real_set
            puzzle = AdventOfCode::Puzzles2024::Day03::Part2.new

            assert_equal 99_532_691, puzzle.answer
          end
        end
      end
    end
  end
end
