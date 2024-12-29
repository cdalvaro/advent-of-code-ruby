# frozen_string_literal: true

require "test_helper"
require "puzzles/2024/day05/day05"

module AdventOfCode
  module Test
    module Puzzles2024
      module Day05
        ##
        # Tests Day 5 (2024) - Part 1
        class Part1Test < Minitest::Test
          def setup
            # Do nothing
          end

          def teardown
            # Do nothing
          end

          def test_part1_answer_test_set
            input_file = "#{File.dirname(__FILE__)}/test_data.txt"
            puzzle = AdventOfCode::Puzzles2024::Day05::Part1.new(file: input_file)

            assert_equal 143, puzzle.answer
          end

          def test_part1_answer_real_set
            puzzle = AdventOfCode::Puzzles2024::Day05::Part1.new

            assert_equal 5_329, puzzle.answer
          end
        end

        ##
        # Tests Day 5 (2024) - Part 2
        class Part2Test < Minitest::Test
          def setup
            # Do nothing
          end

          def teardown
            # Do nothing
          end

          def test_part2_answer_test_set
            input_file = "#{File.dirname(__FILE__)}/test_data.txt"
            puzzle = AdventOfCode::Puzzles2024::Day05::Part2.new(file: input_file)

            assert_equal 123, puzzle.answer
          end

          def test_part2_answer_real_set
            puzzle = AdventOfCode::Puzzles2024::Day05::Part2.new

            assert_equal 5_833, puzzle.answer
          end
        end
      end
    end
  end
end
