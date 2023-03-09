# frozen_string_literal: true

require "bin_magick"
require "rmagick"

#
# Handles image processing using the RMagick and BinMagick libs.
#
module ImageProcessor
  private

  #
  # Read image from file self.input_filename.
  #
  # @raise IOError
  #   When file 'filename' not found.
  #
  # @return [BinMagick] image
  #
  def _read_image
    raise IOError, "File '#{input_filename}' not found" unless File.exist?(input_filename)

    # Read image using RMagick:
    image = Magick::Image.read(input_filename).first

    # Decorate image object with BinMagick:
    BinMagick.new(image)
  end

  #
  # Edit the image by calling RMagick / BinMagick methods. Only dangerous! methods have an effect.
  #
  def _process_image
    image_processing.each do |method_name, args|
      if binary_image.respond_to?(method_name)
        args ? binary_image.send(method_name, args) : binary_image.send(method_name)
      end
    end
  end
end
