# frozen_string_literal: true

require "test_helper"
require "puzzles/2023/day02"

module AdventOfCode
  module Test
    module Puzzles2023
      module Day02
        class Part1Test < Minitest::Test
          def setup
            # Do nothing
          end

          def teardown
            # Do nothing
          end

          def test_valid_games_test_data_set
            input_file = "#{File.dirname(__FILE__)}/test_data.txt"
            puzzle = AdventOfCode::Puzzles2023::Day02::Part1.new(file: input_file)

            valid_games = puzzle.valid_games(blue: 14, green: 13, red: 12)

            assert_equal [1, 2, 5], valid_games.map(&:id)
          end

          def test_answer_test_data_set
            input_file = "#{File.dirname(__FILE__)}/test_data.txt"
            puzzle = AdventOfCode::Puzzles2023::Day02::Part1.new(file: input_file)

            assert_equal 8, puzzle.answer(blue: 14, green: 13, red: 12)
          end

          def test_answer_input_set
            input_file = "#{File.dirname(__FILE__)}/input.txt"
            puzzle = AdventOfCode::Puzzles2023::Day02::Part1.new(file: input_file)

            assert_equal 2278, puzzle.answer(blue: 14, green: 13, red: 12)
          end
        end

        class Part2Test < Minitest::Test
          def setup
            # Do nothing
          end

          def teardown
            # Do nothing
          end

          def test_valid_games_test_data_set
            input_file = "#{File.dirname(__FILE__)}/test_data.txt"
            puzzle = AdventOfCode::Puzzles2023::Day02::Part2.new(file: input_file)

            minimum_sets = puzzle.minimum_valid_sets

            assert_equal [48, 12, 1560, 630, 36], minimum_sets.values.map(&:power)
          end

          def test_answer_test_data_set
            input_file = "#{File.dirname(__FILE__)}/test_data.txt"
            puzzle = AdventOfCode::Puzzles2023::Day02::Part2.new(file: input_file)

            assert_equal 2286, puzzle.answer
          end

          def test_answer_input_set
            input_file = "#{File.dirname(__FILE__)}/input.txt"
            puzzle = AdventOfCode::Puzzles2023::Day02::Part2.new(file: input_file)

            assert_equal 67_953, puzzle.answer
          end
        end
      end
    end
  end
end
