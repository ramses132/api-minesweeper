# frozen_string_literal: true

# Module Error
module Errors
  # Invalid Argument Error Class
  class InvalidArgumentError < StandardError
    def initialize(message = 'Invalid argument')
      super(message)
    end
  end
end
