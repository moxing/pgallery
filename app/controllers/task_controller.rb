require "image_page"

class TaskController < ApplicationController

  def index
  	if params[:url]
  	  @task_url = params[:url]
      @album_md5 = Digest::MD5.hexdigest(@task_url)
      @task = Rails.cache.read(@album_md5)
      if @task.nil?
        page = ImagePage::Page.new(@task_url)
        @album = page.getAlbumName      
        @list = page.getImgList 
        @task = {:list => @list, :name => @album}
        Rails.cache.write(@album_md5, @task)   
      end
      @task = Task.where(:url => @task_url)
  	end
  end

  def create
    unless params[:task_name].nil?
      task = Task.create({:name => params[:task_name], :url => params[:task_url]})
      cache = Rails.cache.read(params[:album_md5])
      inserts = []
      i = 1;
      cache[:list].each do |img|
        inserts.push("('#{img.gsub('/th/','/i/')}','#{params[:task_name]}_%03d.jpg',#{task.id})" % i)
        i+=1
      end
      sql = "INSERT INTO task_images (url, name, task_id) VALUES #{inserts.join(", ")}"
      TaskImage.connection.execute sql    
      unless params[:task_name].eql?(cache[:name])
        cache[:name] = params[:task_name]
        Rails.cache.write(params[:album_md5], cache) 
      end
    end 

    redirection :action => ''
  end

  def manage
    @task_list = Task.all
    unless params[:task_id].nil?
      @img_list = Task.find(params[:task_id]).task_image
    end
  end

end
