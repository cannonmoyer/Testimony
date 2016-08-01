class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
   	  t.string :name
      t.string :title
      t.text :content
      t.string :status

      t.timestamps null: false
    end
  end
end
