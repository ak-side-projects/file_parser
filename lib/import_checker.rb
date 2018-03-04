require "pathname"
require "set"

class ImportChecker
  def initialize(data_directory = "data", spec_directory = "specs")
    @data_directory = data_directory
    @spec_directory = spec_directory
    @file_types_hash = {}
  end

  def validate_files_and_return_file_types_hash
    cross_validate_data_file_types_against_spec_file_types
    ensure_only_one_spec_file_per_file_type

    @file_types_hash
  end

  private

  def cross_validate_data_file_types_against_spec_file_types
    data_file_types = Set.new(file_types_from_data_files)
    spec_file_types = Set.new(file_types_from_spec_files)

    extra_data_file_types = data_file_types - spec_file_types
    if extra_data_file_types.count > 0
      raise "Data files delivered without corresponding spec files."
    end

    extra_spec_file_types = spec_file_types - data_file_types
    if extra_spec_file_types.count > 0
      raise "Spec files delivered without corresponding data files."
    end
  end

  def ensure_only_one_spec_file_per_file_type
    duplicate_specs = []

    @file_types_hash.each do |_file_type, ft_hash|
      spec_files = ft_hash[@spec_directory]
      duplicate_specs += spec_files if spec_files.count > 1
    end

    if duplicate_specs.any?
      raise "Duplicate specs found: #{duplicate_specs}"
    end
  end

  def file_types_from_data_files
    @data_file_types ||= file_types_from_paths(all_data_files)
  end

  def file_types_from_spec_files
    @spec_file_types ||= file_types_from_paths(all_spec_files)
  end

  def file_types_from_paths(paths)
    paths.map do |path|
      directory = path.dirname.to_s
      basename = File.basename(path.basename.to_s, path.extname.to_s)
      if directory == @data_directory
        basename = basename.split("_")[0..-2].join("_")
      end

      @file_types_hash[basename] ||= {}
      @file_types_hash[basename][directory] ||= []
      @file_types_hash[basename][directory] << path.to_s

      basename
    end
  end

  def all_data_files
    @data_pathnames ||= file_paths_from_directory(@data_directory)
  end

  def all_spec_files
    @spec_pathnames ||= file_paths_from_directory(@spec_directory)
  end

  def file_paths_from_directory(directory)
    Dir["#{directory}/*"].map { |path| Pathname.new(path) }
  end
end
