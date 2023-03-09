# frozen_string_literal: true

require_relative "converter"

#
# Writes result to the console/terminal.
#
class ToConsole < Converter
  #
  # Convert and write to the console.
  #
  def convert
    basic_scripts = super
    _write_to_console(basic_scripts)
  end

  private

  #
  # Output result to the console.
  #
  # @param [Hash{ String => Array<String>}] basic_scripts
  #   Generated BASIC scripts.
  #
  def _write_to_console(basic_scripts)
    basic_scripts.each do |gen_name, script|
      puts("\n-------- ['#{gen_name}' begin] --------")
      puts script
      puts("-------- ['#{gen_name}' end] --------\n\n")
    end
  end
end
