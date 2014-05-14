class CreateTaskImages < ActiveRecord::Migration
  def change
    create_table :task_images do |t|
      t.string :name
      t.string :url
      t.integer :status , default:0
      t.integer :task_id

      t.timestamps
    end
  end
end
