Feature: Upgrade a subscription
  
  In order to get premium features
  a customer
  wants to upgrade to a premium plan.

  Scenario: An admin changes plan pricing
    Given I am logged in as a customer
    And I am subscribed to one of 2 plans
    When I upgrade my subscription
    Then I should see a subscription changed success message
    And I should see the following subscription:
      | Name | Amazing Diamond Plan |
