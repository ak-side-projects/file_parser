require "csv"
require_relative "column_info.rb"

class CsvFileParser
  attr_reader :filepath

  def initialize(filepath)
    @filepath = filepath
  end

  def parse_column_info
    validate_header_row

    data_rows.map do |column_arr|
      column_name = column_arr[0]
      width = column_arr[1]
      datatype = column_arr[2]
      ColumnInfo.new(column_name, width.to_i, datatype)
    end
  end

  private

  def validate_header_row
    header_row == ["column name", "width", "datatype"]
  end

  def header_row
    csv_rows[0]
  end

  def data_rows
    csv_rows[1..-1]
  end

  def parse_file
    # TODO: use CSV#foreach if memory becomes an issue
    CSV.read(@filepath)
  end

  def csv_rows
    @csv_rows ||= parse_file
  end
end
