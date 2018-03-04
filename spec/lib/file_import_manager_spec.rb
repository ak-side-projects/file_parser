require "spec_helper"
require "file_import_manager"

describe FileImportManager do
  describe "validate_and_import" do
    let(:import_checker) { double(:import_checker) }
    let(:file_type_importer) { double(:file_type_importer) }
    let(:file_types_hash) do
      {
        "testformat1" => {
          "specs" => ["specfile"],
          "data" => ["datafile"]
        }
      }
    end

    before do
      allow(ImportChecker).to receive(:new).and_return(import_checker)
      allow(FileTypeImporter).to receive(:new).and_return(file_type_importer)
    end

    it "validates and imports files" do
      expect(import_checker).
          to receive(:validate_files_and_return_file_types_hash).
          and_return(file_types_hash)
      expect(file_type_importer).to receive(:import_data_files)

      FileImportManager.new.validate_and_import
    end
  end
end
