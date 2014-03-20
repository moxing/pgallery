class CreateGalleries < ActiveRecord::Migration
  def change
    create_table :galleries do |t|
      t.string :name
      t.string :url
      t.integer :number

      t.timestamps
    end
  end
end
