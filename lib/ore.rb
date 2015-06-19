require 'yaml'

class Ore
  def initialize(last_name)
    @last_name = last_name
  end

  def first_name
    return '詐欺かも' if suspicious?

    if File.exists?(file_path)
      name_table[@last_name] || '(Unknown)'
    else
      puts "'#{file_path}' is not found."
    end
  end

  private

  def suspicious?
    @last_name == 'オレオレ'
  end

  def file_path
    File.expand_path("../../config/ore.yml", __FILE__)
  end

  def name_table
    YAML.load_file(file_path).map(&:values).to_h.invert
  end
end