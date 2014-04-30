class CreateTaskImages < ActiveRecord::Migration
  def change
    create_table :task_images do |t|
      t.string :name
      t.string :url
      t.integer :status
      t.integer :task_id

      t.timestamps
    end
  end
end
