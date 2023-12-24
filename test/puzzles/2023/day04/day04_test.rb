# frozen_string_literal: true

require "test_helper"
require "puzzles/2023/day04"

module AdventOfCode
  module Test
    module Puzzles2023
      module Day04
        ##
        # Tests Day 4 - Part 1
        class Part1Test < Minitest::Test
          def setup
            # Do nothing
          end

          def teardown
            # Do nothing
          end

          def test_points_test_data_set
            input_file = "#{File.dirname(__FILE__)}/test_data.txt"
            puzzle = AdventOfCode::Puzzles2023::Day04::Part1.new(file: input_file)

            assert_equal [8, 2, 2, 1, 0, 0], puzzle.points
          end

          def test_answer_test_data_set
            input_file = "#{File.dirname(__FILE__)}/test_data.txt"
            puzzle = AdventOfCode::Puzzles2023::Day04::Part1.new(file: input_file)

            assert_equal 13, puzzle.answer
          end

          def test_answer_input_set
            input_file = "#{File.dirname(__FILE__)}/input.txt"
            puzzle = AdventOfCode::Puzzles2023::Day04::Part1.new(file: input_file)

            assert_equal 22_897, puzzle.answer
          end
        end

        ##
        # Tests Day 4 - Part 2
        class Part2Test < Minitest::Test
          def setup
            # Do nothing
          end

          def teardown
            # Do nothing
          end

          def test_total_cards_test_set
            input_file = "#{File.dirname(__FILE__)}/test_data.txt"
            puzzle = AdventOfCode::Puzzles2023::Day04::Part2.new(file: input_file)

            assert_equal([1, 2, 4, 8, 14, 1], puzzle.total_cards.map { |c| c[:copies] })
          end

          def test_answer_test_data_set
            input_file = "#{File.dirname(__FILE__)}/test_data.txt"
            puzzle = AdventOfCode::Puzzles2023::Day04::Part2.new(file: input_file)

            assert_equal 30, puzzle.answer
          end

          def test_answer_input_set
            input_file = "#{File.dirname(__FILE__)}/input.txt"
            puzzle = AdventOfCode::Puzzles2023::Day04::Part2.new(file: input_file)

            assert_equal 5_095_824, puzzle.answer
          end
        end
      end
    end
  end
end
