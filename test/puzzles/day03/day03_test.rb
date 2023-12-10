# frozen_string_literal: true

require "puzzles/day03"

require "minitest/autorun"

module Puzzles
  module Day03
    ##
    # Tests Day 3 - Part 1
    class Part1Test < Minitest::Test
      def setup
        # Do nothing
      end

      def teardown
        # Do nothing
      end

      def test_part_numbers_test_set
        input_file = "#{File.dirname(__FILE__)}/test_data.txt"
        puzzle = AdventOfCode::Puzzles::Day03::Part1.new(file: input_file)

        assert_equal [467, 35, 633, 617, 592, 755, 664, 598], puzzle.part_numbers
      end

      def test_answer_test_data_set
        input_file = "#{File.dirname(__FILE__)}/test_data.txt"
        puzzle = AdventOfCode::Puzzles::Day03::Part1.new(file: input_file)

        assert_equal 4_361, puzzle.answer
      end

      def test_answer_input_set
        input_file = "#{File.dirname(__FILE__)}/input.txt"
        puzzle = AdventOfCode::Puzzles::Day03::Part1.new(file: input_file)

        assert_equal 532_445, puzzle.answer
      end
    end

    ##
    # Tests Day 3 - Part 2
    class Part2Test < Minitest::Test
      def setup
        # Do nothing
      end

      def teardown
        # Do nothing
      end

      def test_gears_test_set
        input_file = "#{File.dirname(__FILE__)}/test_data.txt"
        puzzle = AdventOfCode::Puzzles::Day03::Part2.new(file: input_file)

        assert_equal [[467, 35], [755, 598]], puzzle.gears.map(&:numbers)
      end

      def test_answer_test_data_set
        input_file = "#{File.dirname(__FILE__)}/test_data.txt"
        puzzle = AdventOfCode::Puzzles::Day03::Part2.new(file: input_file)

        assert_equal 467_835, puzzle.answer
      end

      def test_answer_input_set
        input_file = "#{File.dirname(__FILE__)}/input.txt"
        puzzle = AdventOfCode::Puzzles::Day03::Part2.new(file: input_file)

        assert_equal 79_842_967, puzzle.answer
      end
    end
  end
end
