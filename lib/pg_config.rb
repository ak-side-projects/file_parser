class PgConfig
  def self.config
    {
      username: "andrewkayvanfar",
      password: "",
      host: "localhost",
      port: 5432,
      database: "file_importer_development"
    }
  end

  def self.db_url
    "postgresql://#{config[:username]}:#{config[:password]}"\
    "@#{config[:host]}:#{config[:port]}/#{config[:database]}"
  end
end
