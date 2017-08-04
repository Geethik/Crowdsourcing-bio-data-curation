Feature: Provide GSE ID for each array express dataset
  
  As a user
  So that I can know more information about dataset
  I want to know the GSE ID of each dataset
  
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
    
Scenario: Show GSE ID on search
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
    And the "GSE ID" of "E-MTAB-3192" should be "ERP009094"

Scenario: Show empty when no GSE ID(sad path)
    Given I am on the profile page
    And I follow "Search Datasets"
    Then I should be on the SearchAll page
    And I should see "Search Datasets"
    Then I fill in "Search by Keyword" with "tuberculosis"
    And I check "Array Express"
    And I select "RNA assay" from "Experiment type"
    And I press "Search database"
    Then I should see "E-MTAB-5218"
    And the "GSE ID" of "E-MTAB-5218" should be ""
