require 'rails_helper'
describe Partsearchresult do
    #Test serialize
    it '' do
       #debugger
       h=Hash.new()
       h[:a]=1
       h[:b]=2
       h[:c]=3
       @pres = Partsearchresult.new(:keyword => 'ear',:Data_set_results => h)
       @pres.save
       expect(@pres.reload.Data_set_results).to eql(h)
    end
end