Given /the following users exist/ do |users_table|
    users_table.hashes.each do |user|
        User.create!(user)
    end
end

And /^the "(.*)" of "(.*)" should be "(.*)"$/ do |field,accession,value|
    find('tr', text: accession).should have_content(value)
    end


When /^I check "(.*)" of "(.*)"$/ do |field,accession|
    within('tr', text: accession) do
    find(:id, "Relevance").set("checked")
    find(:id, "Relevance").check('selected_keys_save[]')
    
end
end

When /^I uncheck "(.*)" of "(.*)"$/ do |field,accession|
    within('tr', text: accession) do
    find(:id, "Relevance").set("unchecked")
    find(:id, "Relevance").check('selected_keys_save[]')
    
end
end


When /^I write "(.*)" in the text box of "(.*)"$/ do |text,accession|
    within('tr', text: accession) do
    fill_in(:id => "reason_notes", :with => text)
  end
end

And /"(.*)" of "(.*)" should be checked$/ do |field,accession|
     within('tr', text: accession) do
   
    find(:id, "Relevance").should eql?("checked")
end
end

And /"(.*)" of "(.*)" should not be checked$/ do |field,accession|
     within('tr', text: accession) do
   
    find(:id, "Relevance").should eql?("cunhecked")
end
end

 And /^I should see "(.*)" in text box of "(.*)"$/ do |text,accession|
    within('tr', text: accession) do
    find(:id, "reason_notes").should have_content(text)
end
end

Then "the downloaded file content should be:" do |content|
  page.response_headers["Content-Disposition"].should eq "attachment; filename=myfile.csv.csv"
  page.source.should == content
end







