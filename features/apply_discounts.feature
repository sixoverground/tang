Feature: Apply a discount to a customer
  
  In order to get a discounted subscription rate
  a customer
  wants to apply a discount to his account.

  Scenario: A customer enters a discount before subscribing
    Given a coupon exists
    And there is a plan available
    And I am logged in as a customer
    When I enter a coupon code
    And I upgrade my subscription
    Then I should see a reduced charge amount

  Scenario: A customer enters a discount after subscribing
    Given a coupon exists
    And I am logged in as a customer
    And I am subscribed to a plan
    When I enter a coupon code
    Then I should see a reduced charge amount
