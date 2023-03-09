# frozen_string_literal: true

require_relative "img_to_MK90_bas/version"
require_relative "img_to_MK90_bas/to_console"
require_relative "img_to_MK90_bas/to_text_file"


require "logger"

#
# Converts images to the Elektronika MK90 BASIC executable code.
#
class ImgToMK90Bas
  attr_reader :input_filename, :converter, :generators, :line_offset, :line_step, :logger_output, :logger,
              :image_processing, :origin, :dir_name_generator, :kwargs

  attr_accessor :binary_image

  DEF_LINE_STEP = 1
  DEF_LINE_OFFSET = 1

  DEF_X_ORIG = 0
  DEF_Y_ORIG = 0
  DEF_ORIGIN_POINT = { x: DEF_X_ORIG, y: DEF_Y_ORIG }.freeze

  DEF_CONVERTER = ToConsole
  DEF_GENERATORS = { "hex-enh" => GenHexMaskEnhanced }.freeze

  DEF_IMAGE_PROC = { "to_binary!" => nil }.freeze

  DEF_LOG_OUTPUT = $stdout

  DEF_DIR_NAME_GEN = ByFilename

  #
  # @param [String] input_filename
  #   Source image filename.
  #
  # @option [Class] converter (DEF_CONVERTER)
  #
  # @option [Hash{ String => Class }] generators (DEF_GENERATORS)
  #
  # @option [Integer] line_offset (DEF_LINE_OFFSET)
  #
  # @option [Integer] line_step (DEF_LINE_STEP)
  #
  # @option [IO] logger_output (DEF_LOG_OUTPUT)
  #
  # @option [Hash{ String => Object }] image_processing (DEF_IMAGE_PROC)
  #
  # @option [Hash { Symbol => Integer }] origin (DEF_ORIGIN_POINT)
  #
  # @option [Class] dir_name_generator (DEF_DIR_NAME_GEN)
  #
  def initialize(
    input_filename:,
    converter: DEF_CONVERTER,
    generators: DEF_GENERATORS,
    line_offset: DEF_LINE_OFFSET,
    line_step: DEF_LINE_STEP,
    logger_output: DEF_LOG_OUTPUT,
    image_processing: DEF_IMAGE_PROC,
    origin: DEF_ORIGIN_POINT,
    dir_name_generator: DEF_DIR_NAME_GEN,
    **kwargs
  )
    @input_filename = input_filename
    @converter = converter
    @generators = generators
    @line_offset = line_offset
    @line_step = line_step
    @logger_output = logger_output
    @image_processing = image_processing
    @dir_name_generator = dir_name_generator
    @origin = origin
    @kwargs = kwargs
  end

  #
  # Convert image to MK90 BASIC.
  #
  def convert
    @logger = Logger.new(@logger_output)
    @logger.info("Convertion started...")

    @converter.new(self).convert

    @logger.info("Job done.")
  end
end
