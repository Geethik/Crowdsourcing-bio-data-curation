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
    
Scenario: Search ArrayExpress page by filter
  Given I am on the profile page
  And I follow "Search Datasets"
  Then I should be on the SearchAll page
  And I should see "Search Datasets"
  Then I fill in "Search by Keyword" with "tuberculosis"
  And I check "Array Express"
  Then I should see "Experiment type"
  And I select "RNA assay" from "Experiment type"
  And I select "Sequencing assay" from "Technology type"
  And I press "Search database"
  And I should see "E-MTAB-5287"
  And the "Organism" of "E-MTAB-5287" should be "Homo sapiens"
  And the "Assays" of "E-MTAB-5287" should be "84"
  
Scenario: Search ArrayExpress page by keyword
  Given I am on the profile page
  And I follow "Search Datasets"
  Then I should be on the SearchAll page
  And I fill in "Search by Keyword" with "eye"
  And I check "Array Express"
  Then I should see "Experiment type"
  And I press "Search database"
  And I should see "E-MTAB-4097"
  And the "Assays" of "E-MTAB-4097" should be "148"

Scenario: Search ArrayExpress by only filters (sad path)
  Given I am on the profile page
  And I follow "Search Datasets"
  Then I should be on the SearchAll page
  And I check "Array Express"
  Then I should see "Experiment type"
  And I select "RNA assay" from "Experiment type"
  And I select "Sequencing assay" from "Technology type"
  And I press "Search database"
  And I should see "Invalid search! Please enter the search term"
  

