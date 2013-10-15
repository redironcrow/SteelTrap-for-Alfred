require 'net/http'
require 'json'
require 'openssl'
QUERY = ARGV[0].to_s.downcase.strip
require_relative "../lib/sly"

api_url="http://steeltrap.co/api/v1/entries.json"
config = !config ? Sly::Config.new : config
uri = URI.parse(api_url)
params = { query:QUERY, email:config.email, token:config.api_key }
res = Net::HTTP.post_form(uri, params)
response = JSON(res.body)
if response["id"]
  puts "Successfully added query."
else
  puts "Unable to add query to repository."
end
