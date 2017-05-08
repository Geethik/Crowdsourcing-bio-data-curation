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
  And I follow "Search Dataset"
  Then I should be on the SearchAll page
  And I fill in "Search GEO by keyword" with "tuberculosis"
  And I press "Search GEO"
  And I should see "GSE65517"
  And the "No. of Samples" of "GSE65517" should be "13"

Scenario: Search ArrayExpress by only filters (sad path)
  Given I am on the profile page
  And I follow "Search Dataset"
  Then I should be on the SearchAll page
  And I fill in "Search GEO by keyword" with ""
  And I press "Search GEO"
  And I should see "Invalid search"
  

