class Savesearchresult < ActiveRecord::Base
    serialize :data_hash, Hash
end
