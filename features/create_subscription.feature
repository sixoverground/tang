Feature: Subscribe a customer to a plan
  
  In order to get access to application features
  a customer
  wants to subscribe to a plan.

  @javascript
  Scenario: A customer subscribes to a plan
    Given I am logged in as a customer
    And there is a plan available
    And I am on the account subscription page
    When I select a plan
    And I fill in the payment form with:
      | Cardholder name    | John             |
      | Card number        | "4242424242424242" |
      | Expiration (MM/YY) | 12/17            |
      | CVC                | 123              |
      | Zip code           | 90210            |
    And I click the submit payment button
    Then I should see a subscription success message
    And I should see my current plan

  @javascript
  Scenario: A customer subscribes to a plan with an invalid card
    Given I am logged in as a customer
    And there is a plan available
    And I am on the account subscription page
    When I select a plan
    When I fill in the payment form with:
      | Cardholder name    | John             |
      | Card number        | 4000000000000002 |
      | Expiration (MM/YY) | 12/17            |
      | CVC                | 123              |
      | Zip code           | 90210            |
    And I click the submit payment button
    Then I should see a subscription error message
    And the payment form should be blank
