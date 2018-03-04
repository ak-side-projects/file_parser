class TxtFileParser
  attr_reader :filepath

  def initialize(filepath)
    @filepath = filepath
    get_drop_date
  end

  def parse_file(columns)
    rows = []

    File.open(@filepath, "r") do |file|
      file.each_line do |line|
        rows << parse_line(line, columns)
      end
    end

    rows
  end

  def parse_line(line, columns)
    line = line.gsub("\n", "")
    row = []
    char_start = 0

    columns.each do |column|
      width = column.width
      char_end = char_start + width
      value = line[char_start...char_end]
      row << format_value(value, column)
      char_start += width
    end

    row << @date_str

    row
  end

  def format_value(value, column)
    value = value.sub(/\s+\Z/, "")
    if column.datatype == "TEXT"
      value
    elsif column.datatype == "BOOLEAN"
      value = value.to_i
      raise "Unknown boolean value" unless [0, 1].include?(value)
      value == 1
    elsif column.datatype == "INTEGER"
      value.to_i
    end
  end

  def get_drop_date
    return @date_str if @date_str

    path = Pathname.new(@filepath)
    @date_str = File.basename(path.basename.to_s, path.extname).split("_").last
  end
end
