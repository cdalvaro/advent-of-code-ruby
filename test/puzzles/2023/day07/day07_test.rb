# frozen_string_literal: true

require "test_helper"
require "puzzles/2023/day07/day07"
require "puzzles/2023/day07/hand"
require "puzzles/2023/day07/hand_type"

module AdventOfCode
  module Test
    module Puzzles2023
      module Day07
        class HandTypeTest < Minitest::Test
          def setup
            # Do nothing
          end

          def teardown
            # Do nothing
          end

          def test_find_type_five_of_a_kind
            hand_type = AdventOfCode::Puzzles2023::Day07::HandType.new(hand: "AAAAA")

            assert_equal 6, hand_type.id
            assert_equal "Five of a kind", hand_type.name
          end

          def test_find_type_four_of_a_kind
            hand_type = AdventOfCode::Puzzles2023::Day07::HandType.new(hand: "AA8AA")

            assert_equal 5, hand_type.id
            assert_equal "Four of a kind", hand_type.name
          end

          def test_find_type_full_house
            hand_type = AdventOfCode::Puzzles2023::Day07::HandType.new(hand: "23332")

            assert_equal 4, hand_type.id
            assert_equal "Full house", hand_type.name
          end

          def test_find_type_three_of_a_kind
            hand_type = AdventOfCode::Puzzles2023::Day07::HandType.new(hand: "TTT98")

            assert_equal 3, hand_type.id
            assert_equal "Three of a kind", hand_type.name
          end

          def test_find_type_two_pairs
            hand_type = AdventOfCode::Puzzles2023::Day07::HandType.new(hand: "23432")

            assert_equal 2, hand_type.id
            assert_equal "Two pairs", hand_type.name
          end

          def test_find_type_one_pair
            hand_type = AdventOfCode::Puzzles2023::Day07::HandType.new(hand: "A23A4")

            assert_equal 1, hand_type.id
            assert_equal "One pair", hand_type.name
          end

          def test_find_type_high_card
            hand_type = AdventOfCode::Puzzles2023::Day07::HandType.new(hand: "23456")

            assert_equal 0, hand_type.id
            assert_equal "High card", hand_type.name
          end
        end

        # Tests Day 7 - Part 1
        class Part1Test < Minitest::Test
          def setup
            # Do nothing
          end

          def teardown
            # Do nothing
          end

          def test_sort_hands_test_data_set
            input_file = "#{File.dirname(__FILE__)}/test_data.txt"
            puzzle = AdventOfCode::Puzzles2023::Day07::Part1.new(file: input_file)

            assert_equal %w[32T3K KTJJT KK677 T55J5 QQQJA], puzzle.sort_hands.map(&:cards)
          end

          def test_answer_test_data_set
            input_file = "#{File.dirname(__FILE__)}/test_data.txt"
            puzzle = AdventOfCode::Puzzles2023::Day07::Part1.new(file: input_file)

            assert_equal 6440, puzzle.answer
          end

          def test_answer_input_set
            puzzle = AdventOfCode::Puzzles2023::Day07::Part1.new

            assert_equal 253_910_319, puzzle.answer
          end
        end

        ##
        # Tests Day 7 - Part 2
        class Part2Test < Minitest::Test
          def setup
            # Do nothing
          end

          def teardown
            # Do nothing
          end

          def test_sort_hands_test_data_set
            input_file = "#{File.dirname(__FILE__)}/test_data.txt"
            puzzle = AdventOfCode::Puzzles2023::Day07::Part2.new(file: input_file)

            assert_equal %w[32T3K KK677 T55J5 QQQJA KTJJT], puzzle.sort_hands.map(&:cards)
          end

          def test_answer_test_data_set
            input_file = "#{File.dirname(__FILE__)}/test_data.txt"
            puzzle = AdventOfCode::Puzzles2023::Day07::Part2.new(file: input_file)

            assert_equal 5905, puzzle.answer
          end

          def test_answer_input_set
            puzzle = AdventOfCode::Puzzles2023::Day07::Part2.new

            assert_equal 254_083_736, puzzle.answer
          end
        end
      end
    end
  end
end
