Dir["lib/*.rb"].each {|file| require_relative file }
ENVIRONMENT="development"

FileImportManager.new.validate_and_import
