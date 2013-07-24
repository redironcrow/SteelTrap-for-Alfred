QUERY = ARGV[0].to_s.strip
require_relative "../lib/sly"

credentials = QUERY.split(" ")

unless credentials.count == 2
  puts "ERROR: Please use format ST SETUP <EMAIL> <API_KEY>"
  exit
end

config = Sly::Config.new({email:credentials[0], api_key:credentials[1], product_id:0000})
config.save
