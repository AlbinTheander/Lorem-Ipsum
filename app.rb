# encoding: utf-8
$LOAD_PATH.unshift File.dirname(__FILE__) + '/lib'

require "rubygems"
require "sinatra"
require "string_follower"

get "/" do
  send_file "public/index.html"
end

get '/text/:lang/:chars' do
  string_follower = get_string_follower(params[:lang])
  len = params[:chars].to_i

  prefix = "att "
  prefix = "att " if params[:lang] == "se"
  prefix = "das " if params[:lang] == "de"
  prefix = "the " if params[:lang] == "en"
  prefix = "mais" if params[:lang] == "fr"
  result = prefix.dup

 len.times do |i|
    ch = string_follower.random(prefix)
    result << ch
    prefix << ch
    prefix[0] = ""
  end
  print prefix
  result
end

def get_string_follower(lang)
	if not defined? @@followers
		@@followers = Hash.new
	end
	if @@followers[lang] == nil
		@@followers[lang] = StringFollower.new
		feed_file(@@followers[lang], lang)
	end
	return @@followers[lang]
end

def feed_file(string_follower, lang)
  folder = "data/" + lang
  file_names= Dir.entries(folder)-[".", ".."]

  files = file_names.map { |file_name| File.new(folder + "/" + file_name, "rt", {:encoding => "utf-8"}) }

  files[0].lines do |line|
	string_follower.feed(line.downcase + " ")
  end
end
