require "spec_helper"
require "csv_file_parser"

describe CsvFileParser do
  let(:parser) { CsvFileParser.new(filepath) }
  describe "parse_column_info" do
    context "when header row is invalid" do
      let(:filepath) { "spec/bad_specs/bad_header_row.csv" }

      it "raises an error" do
        expect do
          parser.parse_column_info
        end.to raise_error("Header row is invalid.")
      end
    end

    context "when header row is valid" do
      let(:filepath) { "spec/specs/testformat2.csv" }

      it "returns an array of ColumnInfo objects" do
        columns = parser.parse_column_info

        expect(columns.count).to eq(5)
        columns.each do |column|
          expect(column.column_name.class).to eq(String)
          expect(column.width.class).to eq(Integer)
          expect(column.datatype.class).to eq(String)
        end
      end
    end
  end
end
