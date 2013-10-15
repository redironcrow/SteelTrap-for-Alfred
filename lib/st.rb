module St
  VERSION = "1.0"
  BUNDLE_ID = "com.redironcrow.steeltrap"
  
  #API_URL = "http://localhost:3000/api/v1/entries.json"
  API_URL = "http://steeltrap.co/api/v1/entries.json"
  CONFIG_FILE = File.expand_path("~/Library/Application Support/Alfred 2/Workflow Data/#{BUNDLE_ID}/config.json")

  class ConfigFileMissingError < StandardError; end
end

require_relative 'st/workflow_utils.rb'
#require_relative 'st/config.rb'
#require_relative 'st/object.rb'
#require_relative 'st/product.rb'
#require_relative 'st/person.rb'
#require_relative 'st/item.rb'
#require_relative 'st/connector.rb'
#require_relative 'st/interface.rb'
