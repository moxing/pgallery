class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :url
      t.integer :status, default:0

      t.timestamps
    end
  end
end
