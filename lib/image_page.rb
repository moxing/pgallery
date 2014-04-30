require 'net/http'
require 'nokogiri'

module ImagePage
  
  class Page

	  def initialize( url )
	    uri = URI.parse(url)
	    @doc = Nokogiri::HTML(Net::HTTP.get(uri)) 
	  end

	  def getAlbumName( selector = "" )
	  	@album = @doc.title[15..-5].downcase().gsub(" ","_").gsub("_set","")
	  end

      # get picture url list
	  def getImgList( selector = "table td a img.border" )
	  	getAlbumName()
	  	list = Array.new
		index = 1
		@doc.css( selector ).each do |img|
			# file_name = "%s_%03d.jpg" % [@album,index]  
			list.push( img['src'] )
		end

		return list
	  end
  end


end
