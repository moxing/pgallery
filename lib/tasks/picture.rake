namespace :data do
  task :init => :environment do	
  	pic_root = Pgallery::Application.config.file_path
	Dir.foreach(pic_root) do |gallery_direction|
		directory = File.join(pic_root,gallery_direction)
		if File.directory?(directory) && !gallery_direction.eql?(".") && !gallery_direction.eql?("..")
		  Dir.chdir(directory)
		  number = Dir.glob('*.jpg').size
		  time = File.ctime(directory)
		  gallery = Gallery.new( :name => gallery_direction, :number => number, :update_time => time)
		  gallery.save()
		  puts gallery_direction
		end
	end	
  end
end