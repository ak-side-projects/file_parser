require "rspec"
Dir["../lib/*.rb"].each {|file| require_relative file }
ENV["environment"]="test"
