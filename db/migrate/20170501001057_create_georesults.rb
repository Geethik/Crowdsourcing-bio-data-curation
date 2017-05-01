class CreateGeoresult < ActiveRecord::Migration
  def change
    create_table :georesults do |t|
      t.string :keyword
      t.text :data_hash
      
      t.timestamps null: false
    end
  end
end
