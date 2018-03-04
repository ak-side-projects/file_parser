require_relative "import_checker.rb"
require_relative "file_type_importer.rb"

class FileImportManager
  attr_reader :data_directory, :spec_directory

  def initialize(data_directory: "data", spec_directory: "specs")
    @data_directory = data_directory
    @spec_directory = spec_directory
  end

  def validate_and_import
    validate_files
    import_files
  end

  private

  def validate_files
    @file_types_hash = ImportChecker.
        new(@data_directory, @spec_directory).
        validate_files_and_return_file_types_hash
  end

  def import_files
    @file_types_hash.each do |file_type, files_hash|
      FileTypeImporter.new(
        file_type: file_type,
        files_hash: files_hash,
        spec_dir: @spec_directory,
        data_dir: @data_directory
      ).import_data_files
    end
  end
end
