class AddFiltersGeo < ActiveRecord::Migration
  def change
    add_column :geosearchresults, :filter_f1, :string
    add_column :geosearchresults, :filter_f2, :string
    add_column :geosearchresults, :filter_f3, :string
    add_column :geosearchresults, :filter_f4, :string
    add_column :geosearchresults, :filter_f5, :string
    add_column :geosearchresults, :filter_f6, :string
  end
end
