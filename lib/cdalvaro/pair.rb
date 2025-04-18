# frozen_string_literal: true

module Cdalvaro
  ## Class for representing a pair
  class Pair
    ##
    ## The first element of the pair
    # @return [Integer] The first element of the pair
    attr_accessor :first

    ##
    # The second element of the pair
    # @return [Integer] The second element of the pair
    attr_accessor :second

    def initialize(first, second)
      @first = first
      @second = second
    end

    def to_s
      "[#{first}, #{second}]"
    end
  end
end
