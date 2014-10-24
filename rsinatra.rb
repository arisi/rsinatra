#!/usr/bin/env ruby
#encoding: UTF-8

require 'sinatra'
require 'haml'
require 'coffee_script'

$port=6969
if ARGV[0]
  set :haml, :ugly => :true
  set :haml, :remove_whitespace => :true
  set :environment, :production 
  $port=ARGV[0]
end
set :bind => "0.0.0.0", :port => $port

$tick=0

get '/' do
  haml :index
end

post "/ajax" do
  {tick: $tick,stamp:Time.now.to_i}.to_json
end

get '/js/:name.js' do
  content_type 'text/javascript', :charset => 'utf-8'
  coffee(:"js/#{params[:name]}")
end

Thread.new {
  loop do
    sleep 1
    $tick+=1
  end
}  
