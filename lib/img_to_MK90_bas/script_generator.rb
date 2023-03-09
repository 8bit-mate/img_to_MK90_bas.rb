# frozen_string_literal: true

require "MK90_bas_img_generator"
require "MK90_bas_formatter"

#
# Handles BASIC script generation/formating.
#
module ScriptGenerator
  private

  #
  # Generate scripts using each generator from the generators list.
  #
  def _generate_scripts
    bas_scripts = {}

    generators.each do |gen_name, gen_method|
      script = _generate_script(gen_method)

      logger.info("Generated script using the '#{gen_name}' method.")

      bas_scripts[gen_name] = script
    end

    bas_scripts
  end

  #
  # Return executable BASIC script for the image 'binary_image' using generator 'generator'.
  #
  # @param [Class] generator
  #
  # @return [Array<String>]
  #   Executable MK90 BASIC code.
  #
  def _generate_script(generator)
    statement_tokens = _generate_tokens(generator)

    _format_tokens(statement_tokens)
  end

  #
  # Generate tokens of a BASIC script for the image 'binary_image' using generator 'generator'.
  #
  # @param [Class] generator
  #
  # @return [Array<MK90BasImgGenerator::BasicStatement>] statements
  #   List of MK90 BASIC statement tokens.
  #
  def _generate_tokens(generator)
    tokens_generator = MK90BasImgGenerator.new(
      generator: generator,
      binary_image: binary_image,
      **kwargs
    )

    tokens_generator.generate
  end

  #
  # Format list of tokens to an executable BASIC script
  #
  # @param [Array<MK90BasImgGenerator::BasicStatement>] statements
  #   List of MK90 BASIC statement tokens.
  #
  # @return [Array<String>]
  #   Executable MK90 BASIC code.
  #
  def _format_tokens(statements)
    MK90BasFormatter.new(
      statements: statements,
      line_offset: line_offset,
      line_step: line_step,
      **kwargs
    ).format
  end
end
