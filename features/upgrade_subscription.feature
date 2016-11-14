Feature: Change a customer's plan
  
  In order to get premium features
  a customer
  wants to upgrade to a premium plan.

  Scenario: An admin changes plan pricing
    Given there are 2 plans available
    And I am logged in as a customer
    And I am subscribed to a plan
    When I upgrade to a new plan
    Then I should see a subscription update success message
    And I should see the following subscription:
      | Name | Amazing Diamond Plan |
