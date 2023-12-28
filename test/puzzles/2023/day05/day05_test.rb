# frozen_string_literal: true

require "test_helper"
require "puzzles/2023/day05"

module AdventOfCode
  module Test
    module Puzzles2023
      module Day05
        class ConverterTest < Minitest::Test
          attr_reader :converter

          def setup
            source = :seed
            destination = :soil
            relations = [
              AdventOfCode::Puzzles2023::Day05::Relation.new(source: 98...100, destination: 50...52),
              AdventOfCode::Puzzles2023::Day05::Relation.new(source: 50...98, destination: 52...100)
            ]
            @converter = AdventOfCode::Puzzles2023::Day05::Converter.new(source:, destination:, relations:)
          end

          def teardown
            # Do nothing
          end

          def test_conversion
            assert_equal([81, 14, 57, 13], [79, 14, 55, 13].map { |value| converter.convert(value:) })
          end
        end

        class AlmanacTest < Minitest::Test
          attr_reader :almanac, :file

          def setup
            @file = "#{File.dirname(__FILE__)}/test_data.txt"
            @almanac = AdventOfCode::Puzzles2023::Day05::Almanac.new(file:)
          end

          def teardown
            # Do nothing
          end

          def test_seeds_conversion_no_reverse
            converted_values = [79, 14, 55, 13].map do |seed|
              almanac.convert(value: seed, from: :seed, to: :location)
            end

            assert_equal [82, 43, 86, 35], converted_values
          end

          def test_seeds_conversion_reverse
            @almanac = AdventOfCode::Puzzles2023::Day05::Almanac.new(file:, reverse: true)

            converted_values = [82, 43, 86, 35].map do |seed|
              almanac.convert(value: seed, from: :location, to: :seed)
            end

            assert_equal [79, 14, 55, 13], converted_values
          end
        end

        ##
        # Tests Day 5 - Part 1
        class Part1Test < Minitest::Test
          def setup
            # Do nothing
          end

          def teardown
            # Do nothing
          end

          def test_answer_test_data_set
            input_file = "#{File.dirname(__FILE__)}/test_data.txt"
            puzzle = AdventOfCode::Puzzles2023::Day05::Part1.new(file: input_file)

            assert_equal 35, puzzle.answer
          end

          def test_answer_input_set
            input_file = "#{File.dirname(__FILE__)}/input.txt"
            puzzle = AdventOfCode::Puzzles2023::Day05::Part1.new(file: input_file)

            assert_equal 318_728_750, puzzle.answer
          end
        end

        ##
        # Tests Day 5 - Part 2
        class Part2Test < Minitest::Test
          def setup
            # Do nothing
          end

          def teardown
            # Do nothing
          end

          def test_answer_test_data_set
            input_file = "#{File.dirname(__FILE__)}/test_data.txt"
            puzzle = AdventOfCode::Puzzles2023::Day05::Part2.new(file: input_file)

            assert_equal 46, puzzle.answer
          end

          def test_answer_input_set
            skip "Takes too long to run" if ENV["SKIP_SLOW_TESTS"]

            input_file = "#{File.dirname(__FILE__)}/input.txt"
            puzzle = AdventOfCode::Puzzles2023::Day05::Part2.new(file: input_file)

            assert_equal 37_384_986, puzzle.answer
          end
        end
      end
    end
  end
end
