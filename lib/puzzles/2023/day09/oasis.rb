# frozen_string_literal: true

module AdventOfCode
  module Puzzles2023
    module Day09
      ##
      # Class for managing the OASIS reports.
      class OASIS
        ##
        # Class for representing a feature.
        # A feature is a set of values, than can have a predicted value.
        class Feature
          ##
          # Array of values
          # @return [Array<Integer>]
          attr_reader :values

          ##
          # Predicted value. May be nil.
          # @param [Integer]
          # @return [Integer]
          attr_accessor :predicted_value

          ##
          # @param [Array<Integer>] values
          def initialize(values:)
            @values = values
          end
        end

        ##
        # Array of features.
        # @return [Array<Feature>] features
        attr_reader :report

        ##
        # @param [String] file path
        def initialize(file:)
          parse_file(file)
        end

        protected

        ##
        # Parse the file's contents.
        #
        # @param [String] file path
        def parse_file(file)
          file_contents = File.readlines(file, chomp: true)
          @report = file_contents.map do |line|
            Feature.new(values: line.split.map(&:to_i))
          end
        end
      end
    end
  end
end
