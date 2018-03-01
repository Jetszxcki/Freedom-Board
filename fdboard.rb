require 'yaml/store'
require 'yaml'
require 'sinatra'

Feeds = {
  
}

get '/' do
  @title = 'FREEDOM BOARD'
  @search = ''
  erb :start
end

post '/post' do
  @title = 'Freedom Board'
  @message  = params['message']
  @user  = params['user']
  @search = ''
  @store = YAML::Store.new 'posts.yml'
  @time = Time.now.strftime("%m/%d/%Y %H:%M:%S")
  @store.transaction do
    @store ||= {}
    @store[@user+" "+@time] ||= ''
    @store[@user+" "+@time] += @message
  end
  erb :start
end

post '/search' do
  @title = 'FREEDOM BOARD'
  @search  = params['search']
  erb :start
end

get '/' do
  @title = 'Results so far:'
  @store = YAML::Store.new 'posts.yml'
  @posts = @store.transaction { @store['posts'] }
  erb :start
end
