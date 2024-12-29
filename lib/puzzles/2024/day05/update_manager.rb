# frozen_string_literal: true

module AdventOfCode
  module Puzzles2024
    module Day05
      ##
      # Class for managing updates based on ordering rules
      class UpdateManager
        ##
        # @return [Hash<Integer, Array<Integer>>] The ordering rules
        attr_reader :rules

        ##
        # @param ordering_rules [Array<String>] The ordering rules
        # @param separator [String] The separator for the rules
        def initialize(ordering_rules, separator: "|")
          @rules = {}
          ordering_rules.each do |rule|
            first, second = rule.split(separator).map(&:to_i)
            @rules[first] ||= []
            @rules[first] << second
          end
        end

        ##
        # Check if the update is valid
        # @param update [Array<Integer>] The update
        # @return [Boolean] True if the update is valid, false otherwise
        def valid?(update:)
          update.each_with_index do |value, index|
            break if index == update.length - 1

            update[index + 1..].each do |sub_value|
              prior_numbers = rules[sub_value] || []
              return false if prior_numbers.include?(value)
            end
          end
          true
        end

        ##
        # Fix the ordering of the update
        # @param update [Array<Integer>] The update
        # @return [Array<Integer>] The updated fixed
        def fix_ordering(update:)
          sorted = []
          update.each do |value|
            post_values = rules[value] || []
            pre_values = rules.keys.select { |key| rules[key].include?(value) }

            post_values = sorted & post_values
            pre_values = sorted & pre_values

            sorted = pre_values + [value] + post_values
          end
          sorted
        end
      end
    end
  end
end
