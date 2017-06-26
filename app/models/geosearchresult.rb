class Geosearchresult < ActiveRecord::Base
    serialize :data_hash, Hash
end
