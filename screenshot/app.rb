require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?

get '/' do
  '<img src="http://capture.heartrails.com/400x400?https://life-is-tech.com/">'
end