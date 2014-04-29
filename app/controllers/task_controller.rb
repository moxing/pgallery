require 'net/http'
require 'nokogiri'

class TaskController < ApplicationController

  def index
  	if params[:url]
  	  url = params[:url]
  	  @list = getList(url)
  	end
  end

  def history
  end

  private

  def getList( url )
  	uri = URI.parse(url)
  	list = Array.new
  	doc = Nokogiri::HTML(Net::HTTP.get(uri))
	doc.css('table td a img.border').each do |img|
		list.push(img['src'])
	end

	return list
  end  
end
