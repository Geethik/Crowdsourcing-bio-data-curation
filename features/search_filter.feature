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
    And I fill in "Email" with "666@gmail.com" 
    And I fill in "Password" with "foobar"     
    And I press "Log in"
    Then I am on the admin page
    And I follow "Add Question"
    Then I should be on the "SearchArrayExpress" page

Scenario: Search ArrayExpress page by filter
  Given I am on the "SearchArrayExpress" page
  Then I should see "Add Question"
  And I select "RNA assay" from "Experiment type"
  And I select "Sequencing assay" from "Technology type"
  And I press "Search Array Express"
  And I should see "E-MTAB-4571"
  
Scenario: Search ArrayExpress page by keyword
  Given I am on the "SearchArrayExpress" page
  Then I should see "Add Question"
  And I fill in "Search by keyword" with "tuberculosis"
  And I press "Search Array Express"
  And I should see "E-BUGS-155"

Scenario: Search ArrayExpress page by keyword and filters
  Given I am on the "SearchArrayExpress" page
  Then I should see "Add Question"
  And I select "RNA assay" from "Experiment type"
  And I select "Sequencing assay" from "Technology type"
  And I fill in "Search by keyword" with "eye"
  And I press "Search Array Express"
  And I should see "E-GEOD-81254"
  
Scenario: Search ArrayExpress page by keyword and filters (sad path)
  Given I am on the "SearchArrayExpress" page
  Then I should see "Add Question"
  And I press "Search Array Express"
  And I should see "Invalid search"
  
