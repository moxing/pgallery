class PictureController < ApplicationController
	def tba
		p = params[:id]
		direction = p[0..-5]

		render :text => direction
		send_file File.join(Pgallery::Application.config.file_path,direction,p+'.jpg'),:type => "image/jpeg"
	end 
end
