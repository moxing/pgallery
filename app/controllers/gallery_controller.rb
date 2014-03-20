class GalleryController < ApplicationController
  def list
    @list = Gallery.all
  end

  def gallery_detail
    @pic_root = Pgallery::Application.config.file_path
    gallery_id = params[:id]
    @gallery = Gallery.find(gallery_id)
    @list = getGalleryDetail(@gallery[:name])
  end

  def updatelist
    updateGalleryInfo
  	render :text => 'save finished'
  end 

  private
  
  def updateGalleryInfo()
     Dir.foreach(@pic_root) do |gallery_direction|
        directory = File.join(@pic_root,gallery_direction)
        if File.directory?(directory)
          number = Dir.glob( File.join(directory,'*.jpg')).size()
          if number > 10
            gallery = Gallery.new( :name => gallery_direction,:number => number)
            gallery.save
          end
        end
     end
  end

  def getGalleryDetail(name)
      directory = File.join(@pic_root,name)
      if File.directory?(directory)
         list = Array.new
         Dir.glob( File.join(directory,'*.jpg')).each do |f|
           file = File.new(f)
           list.push({:name =>File.basename(f), :size => file.stat.size, :time => file.mtime})
         end
         return list
      end
  end


end
