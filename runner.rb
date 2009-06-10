require 'rubygems'
$:.unshift File.dirname(__FILE__) + '/sinatra/lib'
require 'sinatra'

configure do
	set :sessions, true
	require 'lib/boot'
end

before do
	@auth = Twitter::OAuth.new @@config['key'], @@config['secret'], :sign_in => true
	
	unless session[:access_token].nil? or session[:access_secret].nil?
		@auth.authorize_from_access session[:access_token], session[:access_secret]
	end
	
	@twitter = Twitter::Base.new(@auth)
end

get '/' do
	@tweets = @twitter.user_timeline
	haml :status
end

get '/unauthorised' do
	haml :unauthorised
end

# auth
get '/signin' do
	session[:request_token] = @auth.request_token.token
	session[:request_token_secret] = @auth.request_token.secret
	
	redirect @auth.request_token.authorize_url.gsub('authorize', 'authenticate')
end

get '/auth' do
	@auth.authorize_from_request session[:request_token], session[:request_token_secret]
		
	session[:access_token] = @auth.access_token.token
	session[:access_secret] = @auth.access_token.secret
		
	redirect '/'
end

get '/signout' do
	session.clear
	redirect '/'
end

error Twitter::Unauthorized do
	redirect '/unauthorised'
end
