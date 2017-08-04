Feature: Checkboxes to choose database to search from
  
  As a user
  So that I can choose which database to search from
  I want to choose which db to search from
  
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

Scenario: Verifying checkboxes are unchecked initially
    Given I am on the profile page
    And I follow "Search Datasets"
    Then I should be on the SearchAll page
    And I should see "Search Datasets" 
    And I should see "Array Express"
    And I should see "GEO"
    Then the field "Array Express" should not be checked
    Then the field "GEO" should not be checked
    
Scenario: Search Array Express by choice
    Given I am on the profile page
    And I follow "Search Datasets"
    Then I should be on the SearchAll page
    And I should see "Search Datasets"
    Then I fill in "Search by Keyword" with "tuberculosis"
    And I check "Array Express"
    And I select "DNA Assay" from "Experiment type"
    And I select "Sequencing assay" from "Technology type"
    And I press "Search database"
    Then I should see "E-MTAB-3192"
    
Scenario: Search GEO by choice
    Given I am on the profile page
    And I follow "Search Datasets"
    Then I should be on the SearchAll page
    And I should see "Search Datasets"
    Then I fill in "Search by Keyword" with "tuberculosis"
    And I check "GEO"
    And I press "Search database"
    Then I should see "GSE65517"