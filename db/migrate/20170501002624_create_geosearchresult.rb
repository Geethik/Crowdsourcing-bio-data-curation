class CreateGeosearchresult < ActiveRecord::Migration
  def change
    create_table :geosearchresults do |t|
      t.string :keyword
      t.text :data_hash
      
      t.timestamps null: false
    end
  end
end
