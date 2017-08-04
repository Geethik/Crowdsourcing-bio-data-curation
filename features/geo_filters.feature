Feature: Filters for GEO search
  
  As a user
  So that I can do a filtered search on GEO database
  I want to do a filtered search on GEO database
  
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
    
Scenario: Verify all filters are checked initially
    Given I am on the profile page
    And I follow "Search Datasets"
    Then I should be on the SearchAll page
    And I fill in "Search by Keyword" with "tuberculosis"
    And I check "GEO"
    And I press "Search database"
    And the filter "Expression profiling by array" should be checked
    And the filter "Expression profiling by high throughput sequencing" should be checked
    And the filter "Non-coding RNA profiling by array" should be checked
    And the filter "Non-coding RNA profiling by high throughput sequencing" should be checked
    And the filter "Homo-sapiens" should be checked
    And the filter "Mouse" should be checked
  
Scenario: Uncheck a filter and search
    Given I am on the profile page
    And I follow "Search Datasets"
    Then I should be on the SearchAll page
    And I fill in "Search by Keyword" with "tuberculosis"
    And I check "GEO"
    And I uncheck "Homo-sapiens"
    And I press "Search database"
    Then the filter "Homo-sapiens" should not be checked
    And I should see "GSE48130"
    

   
