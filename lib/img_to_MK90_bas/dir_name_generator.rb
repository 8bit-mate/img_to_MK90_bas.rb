# frozen_string_literal: true

#
# Generates output directory name where *.bas files would be created.
#
class DirNameGenerator; end

#
# Generate directory name by the source filename.
#
class ByFilename < DirNameGenerator
  #
  # @param [String] img_filename
  #   Source image filename.
  #
  # @return [String]
  #   Directory name.
  #
  def generate(img_filename)
    img_filename.gsub(/[^0-9A-Za-z]/, "_")
  end
end
