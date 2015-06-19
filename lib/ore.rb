require 'yaml'

class Ore
  def initialize(last_name)
    @last_name = last_name
  end

  def first_name
    config = YAML.load_file(file_path).map(&:values).to_h.invert
    if first_name = config[@last_name]
      first_name
    else
      @last_name == 'オレオレ' ? '詐欺かも' : '(Unknown)'
    end
  rescue Errno::ENOENT
    print_message file_path
  end

  private

  def file_path
    File.expand_path("../../config/ore.yml", __FILE__)
  end

  def print_message(filepath)
    puts "'#{filepath}' is not found."
  end
end