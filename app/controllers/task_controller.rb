require "image_page"

class TaskController < ApplicationController

  def index
  	if params[:url]
  	  url = params[:url]
  	  page = ImagePage::Page.new(url)
      @album = page.getAlbumName
      @album_md5 = Digest::MD5.digest(url) 
      @list = page.getImgList
      Rails.cache.write(@album_md5, @list)
      # render :json => @list;
  	end
  end

  def create
    if params[:task_name]
      task_name = params[:task_name]
      # url = params[:page_url]

    end
  end

end
