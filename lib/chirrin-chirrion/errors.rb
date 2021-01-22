# frozen_string_literal: true

module ChirrinChirrion
  module Errors
    ToggleNotFound   = Class.new(RuntimeError)
    ToggleIsRequired = Class.new(RuntimeError)
  end
end
