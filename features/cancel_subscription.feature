Feature: Cancel a subscription
  
  In order to opt out of a paid account
  a customer
  wants to cancel their current subscription.

  Scenario: A customer cancels his subscription
    Given I am logged in as a customer
    And I am subscribed to a plan
    When I cancel my subscription
    Then I should see a subscription cancelled success message
    And I should see my free subscription