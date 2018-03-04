require "yaml"

class PgConfig
  def self.config
    return @config if @config

    environment = ENV["environment"] || "development"
    all_config = YAML::load(File.open("config/database.yml"))
    @config = all_config[environment]
  end

  def self.db_url
    "postgresql://#{config["username"]}:#{config["password"]}"\
    "@#{config["host"]}:#{config["port"]}/#{config["database"]}"
  end
end
