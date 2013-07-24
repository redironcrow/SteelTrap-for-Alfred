require 'json'
require 'fileutils'

class St::Config < St::Object
  attr_accessor :email, :api_key, :product_id

  def initialize(attributes={})
    attributes.empty? ? self.load! : self.update!(attributes)
  end

  def load!(file_path="")
    file_path = St::CONFIG_FILE if file_path.empty?

    begin
      File.open(file_path, 'r') { |f| self.update!(JSON(f.read)) }
    rescue Errno::ENOENT, IOError
      raise St::ConfigFileMissingError, "Run ST SETUP <EMAIL> <API_KEY>"
    end
  end

  def save(file_path="")
    file_path = St::CONFIG_FILE if file_path.empty?

    FileUtils.mkpath(File.dirname(file_path))
    
    puts file_path
    File.open(file_path, 'w') { |f| f.puts self.to_json }
  end

  def update!(attributes={})
    self.attr_from_hash!(attributes)
  end
end
