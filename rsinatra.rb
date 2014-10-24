#!/usr/bin/env ruby
#encoding: UTF-8

require 'sinatra'
require 'haml'
require 'coffee_script'
require 'redis'

$redis = Redis.new(:host => '20.20.20.215' ) #the address of rpoll's redis server


$port=6969
if ARGV[0]
  set :haml, :ugly => :true
  set :haml, :remove_whitespace => :true
  set :environment, :production 
  $port=ARGV[0]
end
set :bind => "0.0.0.0", :port => $port

def get_or_post(path, opts={}, &block)
  get(path, opts, &block)
  post(path, opts, &block)
end

get '/' do
  haml :index
end

["/ajax"].each do |path|
  get_or_post path do
    {tick: $redis.get("tick"), spi: $redis.get("spi"), stamp:Time.now.to_i}.to_json
  end
end

get '/js/:name.js' do
  content_type 'text/javascript', :charset => 'utf-8'
  coffee(:"js/#{params[:name]}")
end

