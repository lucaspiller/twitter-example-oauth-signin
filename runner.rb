require 'rubygems'
$:.unshift File.dirname(__FILE__) + '/sinatra/lib'
require 'sinatra'

require 'lib/boot'

before do
	@user = session[:user]
end

get '/' do
	haml :index
end
