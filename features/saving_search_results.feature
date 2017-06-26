Feature: Search for datasets via ArrayExpress fields
  
  As a user
  So that I can search for datasets based on ArrayExpress fields
  I want to search ArrayExpress for datasets based on filtering criteria
  
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
  And I follow "Search Dataset"
  Then I should be on the SearchAll page
  And I should see "Search Datasets"
  Then I fill in "Search ArrayExpress by keyword" with "tuberculosis"
  And I select "DNA Assay" from "Experiment type"
  And I select "Array assay" from "Technology type"
  And I press "Search Array Express"
  And I should see "E-GEOD-83379"
  When I check "Relevance" of "E-GEOD-83379" 
  And I write "Howdy!" in the text box of "E-GEOD-83379"
  And I press "Save and Back"
  Then I should be on the SearchAll page
  And I should see "Curated results saved successfully!"
  
  Then I fill in "Search ArrayExpress by keyword" with "tuberculosis"
  And I select "DNA Assay" from "Experiment type"
  And I select "Array assay" from "Technology type"
  And I press "Search Array Express"
  Then I should see "E-GEOD-83379"
  And "Relevance" of "E-GEOD-83379" should be checked
  And I should see "Howdy!" in text box of "E-GEOD-83379"
  
Scenario: Modifying a previous search
 Given I am on the profile page
  And I follow "Search Dataset"
  Then I should be on the SearchAll page
  And I should see "Search Datasets"
  Then I fill in "Search ArrayExpress by keyword" with "tuberculosis"
  And I select "DNA Assay" from "Experiment type"
  And I select "Array assay" from "Technology type"
  And I press "Search Array Express"
  And I should see "E-GEOD-83379"
  When I check "Relevance" of "E-GEOD-83379"
  And I write "Howdy!" in the text box of "E-GEOD-83379"
  And I press "Save and Back"
  Then I should be on the SearchAll page
  And I should see "Curated results saved successfully!"
  
  Then I fill in "Search ArrayExpress by keyword" with "tuberculosis"
  And I select "DNA Assay" from "Experiment type"
  And I select "Array assay" from "Technology type"
  And I press "Search Array Express"
  Then "Relevance" of "E-GEOD-83379" should be checked
  When I uncheck "Relevance" of "E-GEOD-83379"
  And I press "Save and Back"
  Then I should be on the SearchAll page
  And I should see "Curated results saved successfully!"
  
  Then I fill in "Search ArrayExpress by keyword" with "tuberculosis"
  And I select "DNA Assay" from "Experiment type"
  And I select "Array assay" from "Technology type"
  And I press "Search Array Express"
  Then "Relevance" of "E-GEOD-83379" should not be checked