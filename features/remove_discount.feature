Feature: Remove a discount from a customer
  
  In order to remove a discount
  a customer
  wants to remove an applied coupon from his account.

  Scenario: A customer removes a coupon code after applying
    Given a coupon exists
    And I am logged in as a customer with a coupon
    When I remove the coupon
    Then I should see the full charge amount
