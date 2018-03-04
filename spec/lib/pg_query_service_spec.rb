require "spec_helper"
require "pg_query_service"

describe PgQueryService do
  describe "records_from_table" do
    let(:table_name) { "testformat1" }
    before do
      FileImportManager.new.validate_and_import
    end

    it "returns GenericModel records for a given table" do
      records = PgQueryService.new.records_from_table(table_name)
      records.each do |record|
        expect(record.class).to eq(GenericModel)
      end
    end
  end
end
