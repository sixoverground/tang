Feature: Create a plan
  
  In order to create a new plan
  an admin
  wants to determine how customers should be billed.

  Scenario: An admin creates a new plan
    Given I am logged in as an admin
    When I create a new plan with:
      | Stripe               | gold              |
      | Name                 | Amazing Gold Plan |
      | Currency             | usd               |
      | Amount               | 2000              |
      | Interval             | month             |
    Then I should see a plan created success message
    And I should see the following plan:
      | ID                   | gold              |
      | Name                 | Amazing Gold Plan |
      | Price                | $20.00/month      |
