# encoding: utf-8
$LOAD_PATH.unshift File.dirname(__FILE__) + '/lib'

require "rubygems"
require "sinatra"
require "string_follower"

get "/" do
  redirect "/index.html"
end

get '/text/:lang' do

  string_follower = StringFollower.new
  folder = "data/" + params[:lang]

  file_names= Dir.entries(folder)-[".", ".."]

  files = file_names.map { |file_name| File.new(folder + "/" + file_name, "rt", {:encoding => "utf-8"}) }

  files[0].lines do |line|
    string_follower.feed(line.downcase + " ")
  end

  prefix = "att "
  prefix = "att " if params[:lang] == "se"
  prefix = "das " if params[:lang] == "de"
  prefix = "the " if params[:lang] == "en"
  result = prefix.dup

# 800.times do |i|
#    ch = string_follower.random(prefix)
#    result << ch
#    prefix << ch
#    prefix[0] = ""
#  end
#  result
	"Hej"
end
