Feature: Show filters when database selected
  
  As a user
  So that I can do a filtered search on database chosen
  I want to do a filtered search on database
  
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
    
Scenario: Show filters when database selected
    Given I am on the profile page
    And I follow "Search Datasets"
    Then I should be on the SearchAll page
    And I should see "Search Datasets"
    Then I fill in "Search by Keyword" with "tuberculosis"
    And I check "Array Express"
    And I should see "Experiment type"
    And I should see "Technology type"
    And I press "Search database"
    Then I should see "Experiment type"
    And I should see "Technology type"
    
