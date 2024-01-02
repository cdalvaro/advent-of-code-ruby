# frozen_string_literal: true

require "test_helper"
require "puzzles/2023/day08/day08"

module AdventOfCode
  module Test
    module Puzzles2023
      module Day08
        # Tests Day 8 - Part 1
        class Part1Test < Minitest::Test
          def setup
            # Do nothing
          end

          def teardown
            # Do nothing
          end

          def test_find_path
            input_file = "#{File.dirname(__FILE__)}/test_data_set1.txt"
            puzzle = AdventOfCode::Puzzles2023::Day08::Part1.new(file: input_file)

            assert_equal %i[AAA CCC ZZZ], puzzle.find_path

            input_file = "#{File.dirname(__FILE__)}/test_data_set2.txt"
            puzzle = AdventOfCode::Puzzles2023::Day08::Part1.new(file: input_file)

            assert_equal %i[AAA BBB AAA BBB AAA BBB ZZZ], puzzle.find_path
          end

          def test_answer_test_data_set
            input_file = "#{File.dirname(__FILE__)}/test_data_set1.txt"
            puzzle = AdventOfCode::Puzzles2023::Day08::Part1.new(file: input_file)

            assert_equal 2, puzzle.answer

            input_file = "#{File.dirname(__FILE__)}/test_data_set2.txt"
            puzzle = AdventOfCode::Puzzles2023::Day08::Part1.new(file: input_file)

            assert_equal 6, puzzle.answer
          end

          def test_answer_input_set
            puzzle = AdventOfCode::Puzzles2023::Day08::Part1.new

            assert_equal 19_199, puzzle.answer
          end
        end

        ##
        # Tests Day 8 - Part 2
        class Part2Test < Minitest::Test
          def setup
            # Do nothing
          end

          def teardown
            # Do nothing
          end

          def test_answer_test_data_set
            input_file = "#{File.dirname(__FILE__)}/test_data_set3.txt"
            puzzle = AdventOfCode::Puzzles2023::Day08::Part2.new(file: input_file)

            assert_equal 6, puzzle.answer
          end

          def test_answer_input_set
            puzzle = AdventOfCode::Puzzles2023::Day08::Part2.new

            assert_equal 13_663_968_099_527, puzzle.answer
          end
        end
      end
    end
  end
end
