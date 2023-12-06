# frozen_string_literal: true

require "puzzles/day01"

require "minitest/autorun"

module Puzzles
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

      def test_calibration_values_test_set
        input_file = "#{File.dirname(__FILE__)}/test_data_part1.txt"
        puzzle = AdventOfCode::Puzzles::Day01::Part1.new(file: input_file)

        assert_equal [12, 38, 15, 77], puzzle.calibration_values
      end

      def test_answer_test_set
        input_file = "#{File.dirname(__FILE__)}/test_data_part1.txt"
        puzzle = AdventOfCode::Puzzles::Day01::Part1.new(file: input_file)

        assert_equal 142, puzzle.answer
      end

      def test_answer_real_set
        input_file = "#{File.dirname(__FILE__)}/input.txt"
        puzzle = AdventOfCode::Puzzles::Day01::Part1.new(file: input_file)

        assert_equal 54_450, puzzle.answer
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

      def test_calibration_values_test_set
        input_file = "#{File.dirname(__FILE__)}/test_data_part2.txt"
        puzzle = AdventOfCode::Puzzles::Day01::Part2.new(file: input_file)

        assert_equal [29, 83, 13, 24, 42, 14, 76], puzzle.calibration_values
      end

      def test_answer_test_set
        input_file = "#{File.dirname(__FILE__)}/test_data_part2.txt"
        puzzle = AdventOfCode::Puzzles::Day01::Part2.new(file: input_file)

        assert_equal 281, puzzle.answer
      end

      def test_answer_real_set
        input_file = "#{File.dirname(__FILE__)}/input.txt"
        puzzle = AdventOfCode::Puzzles::Day01::Part2.new(file: input_file)

        assert_equal 54_265, puzzle.answer
      end
    end
  end
end
