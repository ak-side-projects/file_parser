require "pg"
require "csv"
require_relative "pg_config.rb"
require_relative "txt_file_parser.rb"
require_relative "csv_file_parser.rb"

class FileTypeImporter
  attr_reader :file_type, :files_hash, :spec_dir, :data_dir, :db_conn

  def initialize(file_type:, files_hash:, spec_dir:, data_dir:)
    @file_type = file_type
    @files_hash = files_hash
    set_spec_file(files_hash, spec_dir)
    @data_files = files_hash[data_dir]
    @db_conn = PG.connect(PgConfig.db_url)
    set_table_attributes
  end

  def import_data_files
    @data_files.each do |file|
      import_data_file(file)
    end
  end

  private

  # TODO: Add primary key, sequence, and indexes if necessary
  # TODO: sanitize interpolation to avoid sql injection
  def create_table_sql
    sql = "create table if not exists #{@table_name} ( #{columns_sql} );"
  end

  def columns_sql
    sql_arr = @columns.map do |column|
      "#{column.column_name} #{column.sql_datatype}"
    end

    sql_arr << "drop_date date not null"

    sql_arr.join(", ")
  end

  # TODO: Prevent importing the same file twice.
  # TODO: Import data from txt file in batches if experiencing memory issues.
  def import_data_file(file)
    rows = TxtFileParser.new(file).parse_file(@columns)
    csv_file = "#{file}.csv"
    CSV.open(csv_file, "w") do |csv|
      rows.each { |row| csv << row }
    end

    @db_conn.exec(create_table_sql)
    copy_sql = copy_csv_sql(csv_file)
    system("psql -c \"#{copy_csv_sql(csv_file)}\" #{PgConfig.db_url}")
    File.delete(csv_file)
  end

  def copy_csv_sql(csv_file)
    "\\COPY #{@table_name} "\
    "(#{(@columns.map(&:column_name) + ["drop_date"]).join(", ")}) "\
    "FROM '#{csv_file}' WITH (FORMAT csv, DELIMITER ',', HEADER false)"
  end

  def set_table_attributes
    @table_name = @file_type
    @columns = CsvFileParser.new(@spec_file).parse_column_info
  end

  def set_spec_file(files_hash, spec_dir)
    spec_files = files_hash[spec_dir]

    if spec_files.nil? || spec_files.count > 1
      raise "Each file type should have one 1 spec file."
    end

    @spec_file = spec_files.first
  end
end
