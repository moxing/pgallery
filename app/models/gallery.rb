class Gallery < ActiveRecord::Base
  attr_accessible :name, :number, :url, :update_time
end
