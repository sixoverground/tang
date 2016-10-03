Feature: Create a plan
  
  In order to create a new plan
  an admin
  wants to determine how customers should be billed.

  Scenario: An admin creates a new plan
    Given I am logged in as an admin
    And I am on the new plan page
    When I fill in the plan form with:
      | Stripe               | gold              |
      | Name                 | Amazing Gold Plan |
      | Currency             | usd               |
      | Amount               | 2000              |
      | Interval             | month             |
    And I click the create plan button
    Then I should see a plan success message
    And I should see the following plan:
      | ID                   | gold              |
      | Name                 | Amazing Gold Plan |
      | Price                | $20.00/month      |

  Scenario: An admin creates a new plan with invalid input
    Given I am logged in as an admin
    And I am on the new plan page
    When I fill in the plan form with:
      | Stripe               | gold              |
      | Currency             | usd               |
      | Amount               | 2000              |
      | Interval             | month             |
    And I click the create plan button
    Then I should see a plan error message
    And I should see the following plan form field values:
      | Stripe               | gold              |
      | Currency             | usd               |
      | Amount               | 2000              |
      | Interval             | month             |
