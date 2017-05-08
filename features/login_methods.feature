Feature: Add new login methods
    In order to provide login routines to users
    As a admin, I would like to login users
    I want to add a user login function

Background: Users in database
  
Given the following users exist:
    | name   | email            | password | password_confirmation | admin |
    | 666    | 666@gmail.com    | foobar   | foobar                | true  |
    | flyer1 | flyer1@gmail.com | foobar   | foobar                | true  |
    | 444    | 444@gmail.com    | foobar1  | foobar1               | false |

Scenario: Login as admin                     
    Given I am on the "login page"             
    And I fill in "Email" with "666@gmail.com" 
    And I fill in "Password" with "foobar"     
    And I press "Log in"                       
    Then I should be on the admin page         

Scenario: Login as user                      
    Given I am on the "login page"             
    And I fill in "Email" with "444@gmail.com" 
    And I fill in "Password" with "foobar1"    
    And I press "Log in"                       
    Then I should be on the profile page       

Scenario: Signup                              
    Given I am on the "login page"             
    And I follow "Sign up now!"                
    Then I should be on the signup page        
    And I fill in "Email" with "555@gmail.com"  
    And I fill in "Name" with "yolo"            
    And I fill in "Password" with "foobar2"     
    And I fill in "Confirmation" with "foobar2" 
    And I press "Create my account"             
    Then I should be on the profile page        

Scenario: Password too short (sad path)                              
    Given I am on the "login page"                                    
    And I follow "Sign up now!"                                       
    Then I should be on the signup page                                
    When I fill in "Email" with "555@gmail.com"                        
    And I fill in "Name" with "yolo"                                   
    And I fill in "Password" with "hey"                                
    And I fill in "Confirmation" with "hey"                            
    And I press "Create my account"                                   
    Then I should be on the users page                                
    And I should see "Password is too short (minimum is 6 characters)" 
