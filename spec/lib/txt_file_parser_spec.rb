require "spec_helper"
require "txt_file_parser"

describe TxtFileParser do
  describe "parse_file" do
    let(:txt_file) { "spec/data/testformat2_2018-03-01.txt" }
    let(:columns) do
      [
        ColumnInfo.new("name", 10, "TEXT"),
        ColumnInfo.new("valid", 1, "BOOLEAN"),
        ColumnInfo.new("count", 3, "INTEGER"),
        ColumnInfo.new("state", 2, "TEXT"),
        ColumnInfo.new("zipcode", 5, "INTEGER")
      ]
    end
    let(:parser) { TxtFileParser.new(txt_file) }

    it "parses a text file according to specs defined by ColumnInfo objects" do
      lines = parser.parse_file(columns)
      expect(lines.count).to eq(3)
      lines.each do |line|
        expect(line.count).to eq(columns.count + 1) # +1 for drop_date
      end
    end
  end
end
