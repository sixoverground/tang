Feature: Download an invoice PDF from Stripe
  
  In order to download a PDF receipt
  a customer
  wants access to all his receipts.

  Scenario: A customer clicks to download a receipt
    Given I am logged in as a customer
    And I am subscribed to a plan
    And an invoice exists
    When I view my receipts
    Then I should see a list of receipts with download buttons
