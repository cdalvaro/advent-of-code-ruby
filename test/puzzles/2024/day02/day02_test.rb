# frozen_string_literal: true

require "test_helper"
require "puzzles/2024/day02/day02"
require "puzzles/2024/day02/report"

module AdventOfCode
  module Test
    module Puzzles2024
      module Day02
        class ReportTest < Minitest::Test
          def test_tolerance0_safe_is_true
            assert_predicate AdventOfCode::Puzzles2024::Day02::Report.new("7 6 4 2 1"), :safe?
            assert_predicate AdventOfCode::Puzzles2024::Day02::Report.new("1 3 6 7 9"), :safe?
          end

          def test_tolerance0_safe_is_false
            refute_predicate AdventOfCode::Puzzles2024::Day02::Report.new("1 2 7 8 9"), :safe?
            refute_predicate AdventOfCode::Puzzles2024::Day02::Report.new("9 7 6 2 1"), :safe?
            refute_predicate AdventOfCode::Puzzles2024::Day02::Report.new("1 3 2 4 5"), :safe?
            refute_predicate AdventOfCode::Puzzles2024::Day02::Report.new("8 6 4 4 1"), :safe?
          end

          def test_tolerance1_safe_is_true
            assert_predicate AdventOfCode::Puzzles2024::Day02::Report.new("7 6 4 2 1", tolerance: 1), :safe?
            assert_predicate AdventOfCode::Puzzles2024::Day02::Report.new("1 3 2 4 5", tolerance: 1), :safe?
            assert_predicate AdventOfCode::Puzzles2024::Day02::Report.new("8 6 4 4 1", tolerance: 1), :safe?
            assert_predicate AdventOfCode::Puzzles2024::Day02::Report.new("1 3 6 7 9", tolerance: 1), :safe?
          end

          def test_tolerance1_safe_is_false
            refute_predicate AdventOfCode::Puzzles2024::Day02::Report.new("1 2 7 8 9", tolerance: 1), :safe?
            refute_predicate AdventOfCode::Puzzles2024::Day02::Report.new("9 7 6 2 1", tolerance: 1), :safe?
          end
        end

        ##
        # Tests Day 2 (2024) - Part 1
        class Part1Test < Minitest::Test
          def setup
            # Do nothing
          end

          def teardown
            # Do nothing
          end

          def test_answer_test_set
            input_file = "#{File.dirname(__FILE__)}/test_data.txt"
            puzzle = AdventOfCode::Puzzles2024::Day02::Part1.new(file: input_file)

            assert_equal 2, puzzle.answer
          end

          def test_answer_real_set
            puzzle = AdventOfCode::Puzzles2024::Day02::Part1.new

            assert_equal 624, puzzle.answer
          end
        end

        ##
        # Tests Day 1 (2024) - Part 2
        class Part2Test < Minitest::Test
          def setup
            # Do nothing
          end

          def teardown
            # Do nothing
          end

          def test_answer_test_set
            input_file = "#{File.dirname(__FILE__)}/test_data.txt"
            puzzle = AdventOfCode::Puzzles2024::Day02::Part2.new(file: input_file)

            assert_equal 4, puzzle.answer
          end

          def test_answer_real_set
            puzzle = AdventOfCode::Puzzles2024::Day02::Part2.new

            assert_equal 658, puzzle.answer
          end
        end
      end
    end
  end
end
