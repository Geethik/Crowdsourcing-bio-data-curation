Feature: Save Search for datasets via GEO
  
  As a user
  So that I can save the search for datasets based on GEO
  I want to save GEO for datasets 
  
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
  Then I fill in "Search GEO by keyword" with "tuberculosis"
  And I press "Search GEO"
  And I should see "GSE65517"
  When I check "Relevance" of "GSE65517" 
  And I write "Howdy!" in the text box of "GSE65517"
  And I press "Save and Back"
  Then I should be on the SearchAll page
  And I should see "Curated results saved successfully!"
  
  Then I fill in "Search GEO by keyword" with "tuberculosis"
  And I press "Search GEO"
  Then I should see "GSE65517"
  And "Relevance" of "GSE65517" should be checked
  And I should see "Howdy!" in text box of "GSE65517"
  
Scenario: Modifying a previous search
 Given I am on the profile page
  And I follow "Search Dataset"
  Then I should be on the SearchAll page
  And I should see "Search Datasets"
  Then I fill in "Search GEO by keyword" with "tuberculosis"
  And I press "Search GEO"
  And I should see "GSE65517"
  When I check "Relevance" of "GSE65517"
  And I write "Howdy!" in the text box of "GSE65517"
  And I press "Save and Back"
  Then I should be on the SearchAll page
  And I should see "Curated results saved successfully!"
  
  Then I fill in "Search GEO by keyword" with "tuberculosis"
  And I press "Search GEO"
  Then "Relevance" of "GSE65517" should be checked
  When I uncheck "Relevance" of "GSE65517"
  And I press "Save and Back"
  Then I should be on the SearchAll page
  And I should see "Curated results saved successfully!"
  
  Then I fill in "Search GEO by keyword" with "tuberculosis"
  And I press "Search GEO"
  Then "Relevance" of "GSE65517" should not be checked