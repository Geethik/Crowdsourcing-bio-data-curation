class CreateGeosearchresult < ActiveRecord::Migration
  def change
    create_table :geosearchresults do |t|
      t.string :keyword
      t.text :data_hash
      t.text :filter_f1
      t.text :filter_f2
      t.text :filter_f3
      t.text :filter_f4
      t.text :filter_f5
      t.text :filter_f6
      
      t.timestamps null: false
    end
  end
end
