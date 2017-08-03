Feature: Search and save for datasets via ArrayExpress fields
  
  As a user
  So that I can search and save for datasets based on ArrayExpress fields
  I want to search ArrayExpress for datasets based on filtering criteria and save results
  
Background: Users in database
  
Given the following users exist:
    | name   | email            | password | password_confirmation | admin |
    | 666    | 666@gmail.com    | foobar   | foobar                | true  |
    | flyer1 | flyer1@gmail.com | foobar   | foobar                | true  |
    | 444    | 444@gmail.com    | foobar1  | foobar1               | false |

Given I am on the "login page"             
    And I fill in "Email" with "444@gmail.com" 
    And I fill in "Password" with "foobar1"     
    And I press "Log in"
    Then I am on the profile page
    And I should see "Profile"

Scenario: Reviewing Saved Searches
  Given I am on the profile page
  And I follow "Search Datasets"
  Then I should be on the SearchAll page
  And I should see "Search Datasets"
  Then I fill in "Search by Keyword" with "tuberculosis"
  And I check "Array Express"
  Then I should see "Experiment type"
  And I select "DNA Assay" from "Experiment type"
  And I select "Sequencing assay" from "Technology type"
  And I press "Search database"
  And I should see "E-MTAB-3192"
  When I check "Relevance" of "E-MTAB-3192" 
  And I write "Howdy!" in the text box of "E-MTAB-3192"
  And I press "Save and Back"
  Then I should be on the SearchAll page
  And I should see "Curated results saved successfully!"
  
  Then I fill in "Search by Keyword" with "tuberculosis"
  And I check "Array Express"
  And I select "DNA Assay" from "Experiment type"
  And I select "Sequencing assay" from "Technology type"
  And I press "Search database"
  Then I should see "E-MTAB-3192"
  And "Relevance" of "E-MTAB-3192" should be checked
  And I should see "Howdy!" in text box of "E-MTAB-3192"
  
Scenario: Modifying a previous saved search
 Given I am on the profile page
  And I follow "Search Datasets"
  Then I should be on the SearchAll page
  And I should see "Search Datasets"
  Then I fill in "Search by Keyword" with "tuberculosis"
  And I check "Array Express"
  And I select "DNA Assay" from "Experiment type"
  And I select "Sequencing assay" from "Technology type"
  And I press "Search database"
  And I should see "E-MTAB-3192"
  When I check "Relevance" of "E-MTAB-3192"
  And I write "Howdy!" in the text box of "E-MTAB-3192"
  And I press "Save and Back"
  Then I should be on the SearchAll page
  And I should see "Curated results saved successfully!"
  
  Then I fill in "Search by Keyword" with "tuberculosis"
  And I check "Array Express"
  And I select "DNA Assay" from "Experiment type"
  And I select "Sequencing assay" from "Technology type"
  And I press "Search database"
  Then "Relevance" of "E-MTAB-3192" should be checked
  When I uncheck "Relevance" of "E-MTAB-3192"
  And I press "Save and Back"
  Then I should be on the SearchAll page
  And I should see "Curated results saved successfully!"
  
  Then I fill in "Search by Keyword" with "tuberculosis"
  And I check "Array Express"
  And I select "DNA Assay" from "Experiment type"
  And I select "Sequencing assay" from "Technology type"
  And I press "Search database"
  Then "Relevance" of "E-MTAB-3192" should not be checked