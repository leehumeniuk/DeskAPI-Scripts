#!/usr/bin/ruby -w

require 'net/http'
require 'json'
require 'csv'

def http_request(site_id,site_description, s, e)
  #TODO
  uri = URI('https://yoursite.desk.com/api/v2/topics') # POST URI
  req = Net::HTTP::Post.new(uri.path, {'Content-Type' => 'application/json'}) #set Post object (uri and content type header)
  req.basic_auth '<email>', '<password>' #set Post object (auth)

  #set Post object body && convert to json
  req.body = {name: "#{site_id}", description: "#{site_description}"}.to_json

  #send the request
  res = Net::HTTP.start(uri.hostname, uri.port,
    :use_ssl => uri.scheme == 'https') do |http|
      http.request(req)
    end
  if res.is_a?(Net::HTTPSuccess)
    puts "Topic Created!"
    s.write("#{res.body}\n")
    return true
  else
    puts "Oops! Topic not created."
    e.write("#{res.body}")
    return false
  end
end

def parse_csv
count = 0
s = File.open("successLog.txt","a")
e = File.open("errorLog.txt","a")


  CSV.foreach("<csv file>") do |row|
    if count == 500
      sleep(60)
      count = 0
    end
    http_request(row[0],row[1], s, e)
    count += 1
  end
  s.close
  e.close
  return count
end

#main
count = parse_csv()
puts "Done!"
