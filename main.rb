Dir["lib/*.rb"].each {|file| require_relative file }
ENV["environment"]="development"
FileImportManager.new.validate_and_import
