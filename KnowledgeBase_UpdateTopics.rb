#!/usr/bin/ruby -w

require 'net/http'
require 'json'

def http_request(topic_id, s, e)

  uri = URI("https://yoursite.desk.com/api/v2/topics/#{topic_id}") # POST URI
  req = Net::HTTP::Patch.new(uri.path, {'Content-Type' => 'application/json'}) #set Post object (uri and content type header)
  req.basic_auth '<email>', '<password>' #set Post object (auth)
  brand_id = <>

  #set Post object body && convert to json
  req.body = {brand_action: "append", brand_ids: [brand_id]}.to_json

  #send the request
  res = Net::HTTP.start(uri.hostname, uri.port,
    :use_ssl => uri.scheme == 'https') do |http|
      http.request(req)
    end
  if res.is_a?(Net::HTTPSuccess)
    puts "Topic Updated!"
    s.write("#{res.body}\n")
    return true
  else
    puts "Oops! Topic not updated."
    e.write("#{res.body}")
    return false
  end
end

def parse_json
count = 0
s = File.open("successLog2.txt","a")
e = File.open("errorLog.txt","a")


  file = File.open('successLog.txt').each_line do |line|
  data_hash = JSON.parse(line)
    if count == 500
      sleep(60)
      count = 0
    end
    http_request(data_hash['id'], s, e)
    count += 1
  end
  s.close
  e.close
  return
end

parse_json()
puts "Complete!"
