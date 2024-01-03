# frozen_string_literal: true

require_relative "oasis"

module AdventOfCode
  module Puzzles2023
    module Day09
      ##
      # Class for solving Day 9 - Part 1 puzzle
      class Part1
        ##
        # The Oasis And Sand Instability Sensor
        # @return [OASIS] oasis
        attr_reader :oasis

        ##
        # @param [String] file path
        def initialize(file: nil)
          file ||= "#{File.dirname(__FILE__)}/input.txt"
          @oasis = OASIS.new(file:)
        end

        ##
        # Get the sum of the predicted values of all features.
        #
        # @return [Integer] the sum of the predicted values
        def answer
          predict_all_features
          oasis.report.sum(&:predicted_value)
        end

        ##
        # Predict the value of all features.
        def predict_all_features
          oasis.report.each do |feature|
            feature.predicted_value = predict(feature:)
          end
        end

        protected

        ##
        # Predict a future value of a feature.
        #
        # @param [Feature] feature
        #
        # @return [Integer] predicted value
        def predict(feature:)
          prediction = 0
          compute_differences(feature:).reverse_each do |diffs|
            prediction += diffs.last
          end
          prediction
        end

        ##
        # Compute the differences of a feature.
        # The differences are computed until all values are zero.
        #
        # @param [Feature] feature
        #
        # @return [Array<Array<Integer>>] differences
        def compute_differences(feature:)
          current_row = feature.values
          differences = [current_row]
          loop do
            current_row = row_differences(current_row)
            break if current_row.all?(&:zero?)

            differences << current_row
          end
          differences
        end

        ##
        # Compute the differences of a row.
        #
        # @param [Array<Integer>] values
        #
        # @return [Array<Integer>] differences
        def row_differences(values)
          values.each_cons(2).map { |a, b| b - a }
        end
      end
    end
  end
end
