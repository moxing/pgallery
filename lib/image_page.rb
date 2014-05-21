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
		  	@album = @doc.title[15..-5].downcase().gsub(" ","_").gsub("_set","").strip
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

  class Image

	  def initialize( gallery )
	    @gallery = gallery
	  	@folder = File.join(Pgallery::Application.config.file_path,@gallery)	    
	  end  	

	  def createFolder
		FileUtils.makedirs(@folder) if File.directory?(@folder)==false
	  end

	  def downloadImg( url, name )
		uri = URI.parse(url)
		Net::HTTP.start(uri.host) do |http|
		    resp = http.get(uri.path)
		    open(File.join(@folder,filename), "wb") do |file|
		        file.write(resp.body)
		    end
		    puts name+" is Done."   
		end	      
	  end

  end
end
