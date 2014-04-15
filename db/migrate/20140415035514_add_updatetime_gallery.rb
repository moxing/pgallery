class AddUpdatetimeGallery < ActiveRecord::Migration
  def change
  	add_column :galleries, :update_time, :datetime
  end
end
