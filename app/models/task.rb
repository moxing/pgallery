class Task < ActiveRecord::Base
  attr_accessible :name, :status, :url
  has_many :task_images
end
