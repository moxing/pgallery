require 'net/http'
require 'nokogiri'

module ImagePage
  
  class Page

	  def initialize( url )
	    uri = URI.parse(url)
	    @doc = Nokogiri::HTML(Net::HTTP.get(uri)) 
	  end

	  def getAlbumName( selector = "" )
	  	if @doc.title
		  	@album = @doc.title[15..-5].downcase().gsub(" ","_").gsub("_set","")
		end
	  end

      # get picture url list
	  def getImgList( selector = "table td a img.border" )
	  	getAlbumName()
	  	list = Array.new
		@doc.css( selector ).each do |img|
			list.push( img['src'] )
		end

		return list
	  end
  end


end
