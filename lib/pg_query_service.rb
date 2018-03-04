require_relative "pg_config.rb"
require_relative "generic_model.rb"

# TODO: allow more comprehensive query operations or use ActiveRecord
class PgQueryService
  attr_reader :conn

  def initialize
    @conn = PG.connect(PgConfig.db_url)
    @conn.type_map_for_results = PG::BasicTypeMapForResults.new(@conn)
  end

  def raw_sql_query(sql)
    @conn.exec(sql)
  end

  def records_from_table(table_name)
    @conn.exec("select * from #{table_name};").map do |hash|
      GenericModel.new(hash)
    end
  end
end

private

def basic_type_map
  @basic_type_map ||= PG::BasicTypeMapForResults.new(@conn)
end
