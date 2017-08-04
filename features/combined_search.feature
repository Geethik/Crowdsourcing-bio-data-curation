Feature: Combined search in both databases
  
  As a user
  So that I search both databases once
  I want to search both databases at same time
  
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
    
Scenario: Search both databases
    Given I am on the profile page
    And I follow "Search Datasets"
    Then I should be on the SearchAll page
    And I should see "Search Datasets"
    Then I fill in "Search by Keyword" with "tuberculosis"
    And I check "Array Express"
    And I check "GEO"
    And I press "Search database"
    Then the field "Array Express" should be checked
    And the field "GEO" should be checked
    And I should see "E-MTAB-3192"
    And I should see "GSE54630"
    
Scenario: Search both databases(sad path)
    Given I am on the profile page
    And I follow "Search Datasets"
    Then I should be on the SearchAll page
    And I should see "Search Datasets"
    Then I fill in "Search by Keyword" with "tuberculosis"
    And I uncheck "Array Express"
    And I uncheck "GEO"
    And I press "Search database"
    Then I should see "Invalid search! Please select a database"