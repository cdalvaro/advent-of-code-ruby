# frozen_string_literal: true

module AdventOfCode
  module Puzzles2024
    module Day02
      ## Class for representing a report
      class Report
        ## The levels of the report
        # @return [Array<Integer>] The levels of the report
        attr_reader :levels

        ## The number of levels that can be discarded
        # @return [Integer] The number of levels that can be discarded
        attr_reader :tolerance

        def initialize(line, tolerance: 0)
          @levels = line.split.map(&:to_i)
          @tolerance = tolerance
        end

        ##
        # Check if the report is safe.
        #
        # @return [Bool] `true` if the report is safe, `false` otherwise
        def safe?
          increasing = positive_trend?
          levels.each_cons(2).with_index do |(a, b), index|
            if increasing != a < b || a == b || (b - a).abs > 3
              return false if tolerance.zero?

              return dup(tolerance - 1).tap { _1.delete_at(index) }.safe? ||
                     dup(tolerance - 1).tap { _1.delete_at(index + 1) }.safe?
            end
          end

          true
        end

        protected

        ##
        # Duplicate the report with a new tolerance if given.
        #
        # @param tolerance [Integer] The new tolerance
        # @return [Report] The duplicated report
        def dup(tolerance = nil)
          Report.new(levels.join(" "), tolerance: tolerance.nil? ? self.tolerance : tolerance)
        end

        ##
        # Delete the level at the given index from the report.
        #
        # @param index [Integer] The index of the level to delete
        # @return [Integer] The deleted level
        def delete_at(index)
          levels.delete_at(index)
        end

        ##
        # Check if the report has a positive trend.
        # The trend is positive if the levels are increasing.
        #
        # @return [Bool] `true` if the trend is positive, `false` otherwise
        def positive_trend?
          n = levels.length
          x = levels.each_index.to_a
          y = levels

          sum_xy = x.zip(y).sum { |ab| ab.inject(:*) }
          sum_xx = x.sum { |a| a**2 }

          m = ((n * sum_xy) - (x.sum * y.sum)).to_f / ((n * sum_xx) - (x.sum**2))
          m.positive?
        end
      end
    end
  end
end
