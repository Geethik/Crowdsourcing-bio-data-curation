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
  And I follow "Search Dataset"
  Then I should be on the SearchAll page
  And I should see "Search Datasets"
  Then I fill in "Search ArrayExpress by keyword" with "tuberculosis"
  And I select "RNA assay" from "Experiment type"
  And I select "Sequencing assay" from "Technology type"
  And I press "Search Array Express"
  And I should see "E-GEOD-76499"
  And the "Organism" of "E-GEOD-76499" should be "Danio rerio"
  And the "Assays" of "E-GEOD-76499" should be "72"
  
Scenario: Search ArrayExpress page by keyword
  Given I am on the profile page
  And I follow "Search Dataset"
  Then I should be on the SearchAll page
  And I fill in "Search ArrayExpress by keyword" with "eye"
  And I press "Search Array Express"
  And I should see "E-MTAB-5563"
  And the "Assays" of "E-MTAB-5563" should be "35"

Scenario: Search ArrayExpress by only filters (sad path)
  Given I am on the profile page
  And I follow "Search Dataset"
  Then I should be on the SearchAll page
  And I select "RNA assay" from "Experiment type"
  And I select "Sequencing assay" from "Technology type"
  And I press "Search Array Express"
  And I should see "Invalid search"
  

