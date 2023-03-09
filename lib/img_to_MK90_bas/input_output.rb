# frozen_string_literal: true

#
# Handles input-output operations with directories and files.
#
module InputOutput
  #
  # Write data to a text file.
  #
  # @param [String] dest_filename
  #
  # @param [Array] data
  #
  def write_data(dest_filename, data)
    file = File.open(dest_filename, "w")

    data.each do |line|
      file.puts(line)
    end
  rescue IOError => e
    logger.error(e.message)
  ensure
    file&.close
  end

  #
  # Create a directory 'dir_name' (if 'dir_name' doesn't exists).
  #
  # @param [String] dir_name
  #   Directory to create.
  #
  def make_dir(dir_name)
    if Dir.exist?(dir_name)
      logger.warn("Output directory '#{dir_name}' already exists!")
    else
      Dir.mkdir(dir_name)
    end
  end
end
