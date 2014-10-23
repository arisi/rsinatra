require "execjs"
require 'sinatra'
require 'haml'
require 'coffee_script'
set :bind => "0.0.0.0", :port => 6969

$tick=0

get '/' do
  haml :index
end

post "/ajax" do
  {tick: $tick}.to_json
end

get '/js/:name.js' do
  content_type 'text/javascript', :charset => 'utf-8'
  coffee(:"js/#{params[:name]}")
end

Thread.new {
  loop do
    puts "tick #{$tick}"
    sleep 1
    $tick+=1
  end
}  
