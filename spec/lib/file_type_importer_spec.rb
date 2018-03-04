require "spec_helper"
require "file_type_importer"
require "pg_config"
require "pg_query_service"

describe FileTypeImporter do
  let(:test_db_config) do
    {
      username: "andrewkayvanfar",
      password: "",
      host: "localhost",
      port: 5432,
      database: "file_importer_test"
    }
  end
  before (:each) do
    allow(PgConfig).to receive(:config).and_return(test_db_config)
  end

  describe "import_data_files" do
    let(:file_type) { "testformat2" }
    let(:files_hash) do
      {
        "data" => ["spec/data/testformat2_2018-03-01.txt"],
        "specs" => ["spec/specs/testformat2.csv"]
      }
    end
    let(:spec_dir) { "specs" }
    let(:data_dir) { "data" }

    it "imports data files using defined specs" do
      records = PgQueryService.new.records_from_table(file_type)
      prior_count = records.count

      fti = FileTypeImporter.new(
        file_type: file_type,
        files_hash: files_hash,
        spec_dir: spec_dir,
        data_dir: data_dir
      )

      fti.import_data_files

      records = PgQueryService.new.records_from_table(file_type)
      expect(records.count).to eq(prior_count + 3)
      records.each do |record|
        expect(record.attributes.count).to eq(6)
        expect(record.name.class).to eq(String)
        expect(record.count.class).to eq(Integer)
        expect(record.valid).to be(true).or be(false)
        expect(record.state.class).to eq(String)
        expect(record.zipcode.class).to eq(Integer)
      end
    end
  end
end
