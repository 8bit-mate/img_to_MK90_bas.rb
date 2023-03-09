# frozen_string_literal: true

require_relative "script_generator"
require_relative "image_processor"

require "delegate"

#
# Generic converter.
#
class Converter < SimpleDelegator
  include ScriptGenerator
  include ImageProcessor

  #
  # Read image and convert it to BASIC scripts.
  #
  def convert
    self.binary_image = _read_image

    _process_image if image_processing

    _generate_scripts
  end
end
