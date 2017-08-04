Feature: Search for datasets via GEO
  
  As a user
  So that I can search for datasets from GEO
  I want to search GEO for datasets based on keyword
  
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
    
Scenario: Search GEO page by keyword
  Given I am on the profile page
  And I follow "Search Datasets"
  Then I should be on the SearchAll page
  And I fill in "Search by Keyword" with "tuberculosis"
  And I check "GEO"
  And I press "Search database"
  And I should see "GSE54630"
  And the "No. of Samples" of "GSE54630" should be "2"

Scenario: Search GEO without keyword (sad path)
  Given I am on the profile page
  And I follow "Search Datasets"
  Then I should be on the SearchAll page
  And I fill in "Search by Keyword" with ""
  And I check "GEO"
  And I press "Search database"
  And I should see "Invalid search! Please enter the search term"
  

