Feature: Subscribe a customer to a plan
  
  In order to get access to application features
  a customer
  wants to subscribe to a plan.

  @javascript
  Scenario: A customer subscribes to a plan
    Given there is a plan available
    And I am logged in as a customer
    When I upgrade my subscription
    And I complete the payment form with:
      | Cardholder name    | John               |
      | Card number        | "4242424242424242" |
      | Expiration (MM/YY) | 12/17              |
      | CVC                | 123                |
      | Zip code           | 90210              |
    Then I should see a subscription created success message
    And I should see my current subscription
    And I should be an active customer

