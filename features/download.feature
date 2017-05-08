Feature: Download search results. 
  
  As a user
  So that I can download search results
  I want to download search results
  
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
  And I select "DNA Assay" from "Experiment type"
  And I select "Sequencing assay" from "Technology type"
  And I press "Search Array Express"
  When I follow "Download"
  Then the downloaded file content should be:
    """
    Accession,Name,Type,Organism,Release_Date,Assays,Relevance,Reason
    E-MTAB-3192,Genome-wide maps of H3K4me1 in Mycobacterium tuberculosis H37Rv-infected macrophages,ChIP-seq,Homo sapiens,2015-10-15,14,unchecked,""
    E-MTAB-2492,ChIP-seq of Mycobacterium tuberculosis with anti-GlnR antibody to study the role of the GlnR regulon in a nitrogen stress environment,ChIP-seq,Mycobacterium tuberculosis,2014-12-01,4,unchecked,""
    E-MTAB-2390,Genomic mapping of cAMP receptor protein binding in relation to transcriptional start sites in Mycobacterium tuberculosis,ChIP-seq,Mycobacterium tuberculosis,2014-06-24,15,unchecked,""
    E-GEOD-54241,The PhoP-dependent ncRNA Mcr7 modulates the TAT secretion system in Mycobacterium tuberculosis,ChIP-seq,Mycobacterium tuberculosis H37Rv,2014-06-02,3,unchecked,""
    E-GEOD-54239,The PhoP-dependent ncRNA Mcr7 modulates the TAT secretion system in Mycobacterium tuberculosis [ChIP-Seq],ChIP-seq,Mycobacterium tuberculosis H37Rv,2014-06-02,3,unchecked,""
    E-GEOD-48164,"Genome-wide mapping of CarD, RNAPs, and RNAPb on the Mycobacterium smegmatis genome using Chromatin Immunoprecipitation Sequencing",ChIP-seq,Mycobacterium smegmatis,2013-08-01,7,unchecked,""
    E-GEOD-40845,High-resolution transcriptome and genome-wide dynamics of RNA polymerase and NusA in Mycobacterium tuberculosis (ChIP-seq),ChIP-seq,Mycobacterium tuberculosis,2012-12-01,10,unchecked,""
    E-GEOD-35149,Virulence regulator EspR of Mycobacterium tuberculosis is a nucleoid-associated protein,ChIP-seq,Mycobacterium tuberculosis,2012-04-02,3,unchecked,""

    """
  