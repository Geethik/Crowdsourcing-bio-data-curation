Given /the following users exist/ do |users_table|
    users_table.hashes.each do |user|
        User.create!(user)
    end
end

And /^I annotate "(.*)" $/ do |choice|
    find_field[choice].select("RNA Assay")
end








