Feature: Save Search for datasets via GEO
  
  As a user
  So that I can save the search for datasets based on GEO
  I want to save the search results for GEO database 
  
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
  And I check "GEO"
  And I press "Search database"
  And I should see "GSE65517"
  When I check "Relevance_geo" of "GSE65517"
  And I write "Howdy!" in the text box of "GSE65517"
  And I press "Save and Back"
  Then I should be on the SearchAll page
  And I should see "Curated results saved successfully!"
  
  Then I fill in "Search by Keyword" with "tuberculosis"
  And I check "GEO"
  And I press "Search database"
  Then I should see "GSE65517"
  And "Relevance_geo" of "GSE65517" should be checked
  And I should see "Howdy!" in text box of "GSE65517"
  
Scenario: Modifying a previous saved search
 Given I am on the profile page
  And I follow "Search Dataset"
  Then I should be on the SearchAll page
  And I should see "Search Datasets"
  Then I fill in "Search by Keyword" with "tuberculosis"
  And I check "GEO"
  And I press "Search database"
  And I should see "GSE65517"
  When I check "Relevance_geo" of "GSE65517"
  And I write "Howdy!" in the text box of "GSE65517"
  And I press "Save and Back"
  Then I should be on the SearchAll page
  And I should see "Curated results saved successfully!"
  
  Then I fill in "Search by Keyword" with "tuberculosis"
  And I check "GEO"
  And I press "Search database"
  Then "Relevance_geo" of "GSE65517" should be checked
  When I uncheck "Relevance_geo" of "GSE65517"
  And I press "Save and Back"
  Then I should be on the SearchAll page
  And I should see "Curated results saved successfully!"
  
  Then I fill in "Search by Keyword" with "tuberculosis"
  And I check "GEO"
  And I press "Search database"
  Then "Relevance_geo" of "GSE65517" should not be checked