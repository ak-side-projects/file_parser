require "spec_helper"
require "import_checker"

describe ImportChecker do
  let(:checker) { ImportChecker.new(data_dir, spec_dir) }

  describe "validate_files_and_return_file_types_hash" do
    let(:spec_dir) { "spec/specs" }

    context "when data file is missing spec file" do
      let(:data_dir) { "spec/bad_data" }
      let(:files_arr) { Dir["#{data_dir}/*"] }

      it "raises an error" do
        expect do
          checker.validate_files_and_return_file_types_hash
        end.to raise_error("Data files delivered without corresponding "\
                           "spec files.")
      end
    end

    context "when data files each have just one spec" do
      let(:data_dir) { "spec/data" }
      let(:file_types) { ["testformat1", "testformat2"] }

      it "returns a hash of file_types mapping to data and spec files" do
        hash = checker.validate_files_and_return_file_types_hash
        expect(hash.keys).to eq(file_types)
        file_types.each do |file_type|
          data_files = hash[file_type][data_dir]
          expect(data_files.count).to be > 0
          spec_files = hash[file_type][spec_dir]
          expect(spec_files.count).to eq(1)
        end
      end
    end
  end
end
