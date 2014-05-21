namespace :data do
  task :init => :environment do	
	@pic_root = Pgallery::Application.config.file_path
  end

  task :download => :init do
  	task = Task.where(['name = ?', @gallery]).first
  	FileUtils.makedirs(@folder) if File.directory?(@folder)==false
  	# ip = ImagePage::Image.new( task.name )
  	# ip.createFolder
  	list = task.task_images.where(:status => 0)
  	list.each do |item|
		uri = URI.parse(item.url)
		Net::HTTP.start(uri.host) do |http|
		    resp = http.get(uri.path)
		    open(File.join(@folder,item.name), "wb") do |file|
		        file.write(resp.body)
		    end
		    puts item.name+" is Done."
		    item.status = 1
		    item.save
		end
  	end
  end

  task :createGallery => :init do
	Dir.foreach(@pic_root) do |gallery_direction|
		directory = File.join(@pic_root,gallery_direction)
		if File.directory?(directory) && !gallery_direction.eql?(".") && !gallery_direction.eql?("..")
		  Dir.chdir(directory)
		  list = Dir.glob('*.jpg')
		  number = list.size
		  time = File.ctime(directory)
		  if number > 10
			  gallery = Gallery.new( :name => gallery_direction, :number => number, :update_time => time)
			  gallery.save()
			  # puts gallery_direction
		  end
		end
	end
  end

  task :createThumb => :init do

	put_policy = Qiniu::Auth::PutPolicy.new(:pgallery)

	# uptoken = Qiniu::Auth.generate_uptoken(put_policy)  	
	p = File.join(@pic_root,'maple_08\maple_08_001.jpg')
	key = 'tba/maple_08_001.jpg'
	result = Qiniu::Storage.upload_with_put_policy(put_policy,p,key)
  end
end