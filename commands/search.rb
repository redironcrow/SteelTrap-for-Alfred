require 'net/http'
require 'json'
require 'openssl'
QUERY = ARGV[0].to_s.downcase.strip
require_relative "../lib/sly"
require_relative "../lib/st"

config = !config ? Sly::Config.new : config
uri = URI.parse(St::API_URL)
params = { email:config.email, token:config.api_key }
uri.query = URI.encode_www_form( params )
request = Net::HTTP::Get.new(uri.to_s)
response = Net::HTTP.start(
  uri.host,
  uri.port, 
  :use_ssl => (uri.scheme == 'https'), 
  :verify_mode => OpenSSL::SSL::VERIFY_NONE
) do |http|
  http.request(request)
end
response = JSON(response.body)

options = []
response.each do |f|
  if f['query'].downcase.include? QUERY
    options << {
      uid:f['user_id'],
      arg:f['id'],
      title:f['query'],
      icon:'icon.png'
    }
  end
end
arg = 'test'
puts Sly::WorkflowUtils.results_feed(options)
