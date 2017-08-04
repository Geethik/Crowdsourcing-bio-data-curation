Given /the following users exist/ do |users_table|
    users_table.hashes.each do |user|
        User.create!(user)
    end
end

And /^the "(.*)" of "(.*)" should be "(.*)"$/ do |field,accession,value|
    find('tr', text: accession).should have_content(value)
end

And /^the field "(.*)" should not be checked$/ do |field|
    if(field=="Array Express")
        find(:id, "AE_check").should eql?("unchecked")
    end
    if(field=="GEO")
        find(:id, "GEO_check").should eql?("unchecked")
    end
end
And /^the field "(.*)" should be checked$/ do |field|
    if(field=="Array Express")
        find(:id, "AE_check").should eql?("checked")
    end
    if(field=="GEO")
        find(:id, "GEO_check").should eql?("checked")
    end
end

And /^the filter "(.*)" should be checked$/  do |field|
    field_checked = find_field(field)['checked']
    field_checked.should eql?("checked")
end

And /^the filter "(.*)" should not be checked$/ do |field|
    field_unchecked = find_field(field)['unchecked']
    field_unchecked.should eql?("unchecked")
end

When /^I check "(.*)" of "(.*)"$/ do |field,accession|
    within('tr', text: accession) do
        if(!first(:id,"Relevance").nil?)
            find(:id, "Relevance").set("checked")
            find(:id, "Relevance").check('selected_keys_save[]')
        end
        if(!first(:id,"Relevance_geo").nil?)
            find(:id, "Relevance_geo").set("checked")
        find(:id, "Relevance_geo").check('selected_keys_save_geo[]')
        end
    
end
end

When /^I uncheck "(.*)" of "(.*)"$/ do |field,accession|
    within('tr', text: accession) do
        if(!first(:id, "Relevance").nil?)
            find(:id, "Relevance").set("unchecked")
            find(:id, "Relevance").check('selected_keys_save[]')
        end
        if(!first(:id, "Relevance_geo").nil?)
            find(:id, "Relevance_geo").set("unchecked")
            find(:id, "Relevance_geo").check('selected_keys_save_geo[]')
        end
end
end


When /^I write "(.*)" in the text box of "(.*)"$/ do |text,accession|
    within('tr', text: accession) do
    
    if(!first(:id,"reason_notes").nil?)    
        fill_in(:id => "reason_notes", :with => text)
    end
    if(!first(:id,"reason_notes_geo").nil?)
        fill_in(:id => "reason_notes_geo", :with => text)
    end
  end
end

And /"(.*)" of "(.*)" should be checked$/ do |field,accession|
     within('tr', text: accession) do
        if(!first(:id, "Relevance").nil?)
            find(:id, "Relevance").should eql?("checked")
        end
        if(!first(:id, "Relevance_geo").nil?)
            find(:id, "Relevance_geo").should eql?("checked")
        end
end
end

And /"(.*)" of "(.*)" should not be checked$/ do |field,accession|
     within('tr', text: accession) do
        if(!first(:id, "Relevance").nil?)
            find(:id, "Relevance").should eql?("unhecked")
        end
        if(!first(:id, "Relevance_geo").nil?)
            find(:id, "Relevance_geo").should eql?("unchecked")
        end
end
end

 And /^I should see "(.*)" in text box of "(.*)"$/ do |text,accession|
    within('tr', text: accession) do
        if(!first(:id, "reason_notes").nil?)
            find(:id, "reason_notes").should have_content(text)
        end
        if(!first(:id, "reason_notes_geo").nil?)
            find(:id, "reason_notes_geo").should have_content(text)
        end
end
end

Then "the downloaded file content should be:" do |content|
  page.response_headers["Content-Disposition"].should eq "attachment; filename=myfile.csv.csv"
  page.source.should == content
end







