Feature: Create a coupon
  
  In order to provide discounts to customers
  an admin
  wants to create a coupon.

  Scenario: An admin creates a new coupon
    Given I am logged in as an admin
    When I create a new coupon with:
      | Percent off | 50         |
      | Duration    | forever    |
      | ID (Code)   | half-price |
    Then I should see a coupon created success message
    And I should see the following coupon:
      | ID          | half-price |
      | Percent off | 50% off    |
      | Duration    | forever    |
