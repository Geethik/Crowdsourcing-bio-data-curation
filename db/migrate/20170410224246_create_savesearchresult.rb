class CreateSavesearchresult < ActiveRecord::Migration
  def change
    create_table :savesearchresults do |t|
      t.string :keyword
      t.string :filter_exper
      t.string :filter_tech
      t.text :data_hash
      
      t.timestamps null: false
    end
  end
end
