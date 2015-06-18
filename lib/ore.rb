require 'yaml'

class Ore
  def self.firstname(lastname)
    filepath = File.expand_path("../../config/ore.yml", __FILE__)
    ore = load_file filepath
    find_ore = ore.find { |row| row['lastname'] == lastname }
    find_ore ? find_ore['firstname'] : 怪しむ(lastname)
  end

  def self.load_file(filepath)
    begin
      YAML.load_file filepath
    rescue Errno::ENOENT
      print_message filepath
    rescue
      raise
    end
  end

  def self.怪しむ(lastname)
    lastname == 'オレオレ' ? '詐欺かも' : '(Unknown)'
  end

  def self.print_message(filepath)
    puts "'#{filepath}' is not found."
  end
end