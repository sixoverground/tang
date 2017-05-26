Feature: Begin a subscription with a free trial period
  
  In order to try a plan for free
  a customer
  subscribes to a plan with a free trial period.

  @javascript
  Scenario: An admin defines a plan trial period
    Given there is a trial plan available
    And I am logged in as a customer
    When I upgrade my subscription
    And I complete the payment form with:
      | Cardholder name    | John               |
      | Card number        | "4242424242424242" |
      | Expiration (MM/YY) | 12/17              |
      | CVC                | 123                |
      | Postal code        | 90210              |
    Then I should receive a free trial period

