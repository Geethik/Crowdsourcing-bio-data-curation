Feature: Search for datasets similar ArrayExpress fields
 Given that I am on the "profile" page
  And I press "Search"
  Then I should be on the "SearchArrayExpress" page
  
Scenario: Search ArrayExpress page
  Given that I am on the "SearchArrayExpress" page
  And I select "organism" as "HomoSapiens"
  And I select "assays" as "RNA Assay"
  And I select "technologies" as "Sequencing Assay"
  And I select "arrays" as "All arrays"
  And I press "Search"
  Then I should be on the "SearchResults" page
  And I should see "Accession" "E-MTAB-5316"
  But I should not see "Accession" "E-GEOD-81664"
  
Scenario: Mark results as relevant
  Given that I am on the "SearchResults" page
  And I click on "relevant" for "Accession" "E-MTAB-5316"
  And I click on "relevant" for "Accession" "E-MTAB-4752"
  Then I should be on the "CuratedResults" page
  And I should see "Accession" "E-MTAB-5316"
  And I should see "Accession" "E-MTAB-4752"
  But I should not see "Accession" "E-MTAB-5162"
  
Scenario: Not selecting a filter field while searching (sad path)
  Given that I am on the "SearchArrayExpress" page
  And I select "organism" as "nil"
  And I press "Search"
  Then I should be on the "SearchArrayExpress" page
  And I should see a flash "organism not selected"