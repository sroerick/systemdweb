require 'rubygems'
require 'sinatra'

get '/' do
  servicefile = File.open("services.config")
  servicelist = servicefile.readlines.map(&:chomp)
  @statuslist = Array.new
  for i in servicelist
    status = `sudo systemctl status #{i}`
    output = Array[i, status]
    @statuslist.append(output)
    #require 'pry'; binding.pry
  end
  erb :index
end

get '/activate/*' do
  servicefile = File.open("services.config")
  servicelist = servicefile.readlines.map(&:chomp)
  i = params['splat']
  if servicelist.include?(i[0])
    then
      `sudo systemctl start #{i[0]}`
  redirect '/ruby/'
  else
    'bad boy'
  end
end

get '/deactivate/*' do
  servicefile = File.open("services.config")
  servicelist = servicefile.readlines.map(&:chomp)
  i = params['splat']
  if servicelist.include?(i[0])
    then
      `sudo systemctl stop #{i[0]}`
  redirect '/ruby/'
  else
    'bad boy'
  end
end
