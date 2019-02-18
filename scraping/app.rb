require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?

require 'open-uri'
require 'nokogiri'

get '/' do
  @links = Array.new
  @imgs = Hash.new
  url = 'http://lit.gahaku.tech/old/'
  html = open(url).read
  parsed_html = Nokogiri::HTML.parse(html,nil,'utf-8')
  # parsed_html.to_html
  i=0
  parsed_html.css('ul.supporter-list').css('li').each do |node|
    anchor = node.css('a')
    @links[i] = anchor.attribute('href').value.match(/https?:\/\/(?:www\.)?(?:jp\.)?(?:info\.)?(?:docs\.)?([^\.]*)/)[1]
    temp = anchor.css('img')
    temp.attribute('src').value = url + temp.attribute('src').value
    @imgs[@links[i]] = temp.to_html
    i = i+1
  end
  erb :index
end