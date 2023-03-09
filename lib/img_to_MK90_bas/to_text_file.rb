# frozen_string_literal: true

require_relative "input_output"
require_relative "converter"
require_relative "dir_name_generator"

#
# Writes result to to local text files.
#
class ToTextFile < Converter
  include InputOutput

  #
  # Convert to local text files.
  #
  def convert
    logger.info("Output to: local files.")

    basic_scripts = super

    output_dir_path = dir_name_generator.new.generate(input_filename)

    logger.info("Generation is done, preparing to write files. Output directory is: '#{output_dir_path}'.")

    make_dir(output_dir_path)

    _write_text_files(basic_scripts, output_dir_path)
  end

  private

  #
  # Write text file for each generated script.
  #
  # @param [Hash{ String => Array<String>}] basic_scripts
  #   Generated BASIC scripts.
  #
  # @param [String] output_dir_path
  #
  def _write_text_files(basic_scripts, output_dir_path)
    basic_scripts.each do |gen_name, script|
      filename = "#{gen_name}.bas"
      dest_filename = File.join(output_dir_path, filename)
      logger.info("Writing the file: '#{dest_filename}'...")

      write_data(dest_filename, script)

      logger.info("...OK!")
    end
  end
end
