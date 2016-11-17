Feature: Switch customers to new plan pricing
  
  In order to subscribe customers to a new plan price
  an admin
  wants to delete the old plan and subscribe customers to the new one.

  Scenario: An admin changes plan pricing
    Given a customer is subscribed to a plan
    And I am logged in as an admin
    When I create a new plan with:
      | Stripe               | gold2                 |
      | Name                 | Amazing New Gold Plan |
      | Currency             | usd                   |
      | Amount               | 4000                  |
      | Interval             | month                 |
    And I change a subscription to the new plan
    Then I should see a subscription updated success message
    And I should see the following subscription:
      | Name | Amazing New Gold Plan |
