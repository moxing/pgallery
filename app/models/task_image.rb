class TaskImage < ActiveRecord::Base
  attr_accessible :name, :status, :task_id, :url
  belongs_to :task
end
