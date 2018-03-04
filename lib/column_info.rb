class ColumnInfo
  DATATYPES = ["TEXT", "BOOLEAN", "INTEGER"]

  attr_reader :column_name, :width, :datatype

  def initialize(column_name, width, datatype)
    @column_name = column_name.split(" ").join("_")
    @width = width
    @datatype = datatype

    validate_inputs
  end

  def sql_datatype
    case @datatype
    when "TEXT"
      "varchar(#{@width})"
    when "BOOLEAN"
      "boolean"
    when "INTEGER"
      "integer"
    end
  end

  private

  def validate_inputs
    raise "column_name must be a string" unless @column_name.is_a?(String)
    raise "width must be an integer" unless @width.is_a?(Integer)
    raise "datatype must be a string" unless @datatype.is_a?(String)
  end

  def validate_datatype
    unless DATATYPES.include?(@datatype)
      raise "Unknown datatype #{column.datatype} for "\
            "column #{column.column_name}"
    end
  end
end
