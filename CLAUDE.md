# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Tang is a Ruby gem (Rails engine) that provides Stripe subscription management. It's published as both a Ruby gem (`tang`) and an npm package (`@sixoverground/tang`). It uses a dummy Rails app at `spec/tang_app/` for development and testing.

## Common Commands

### Running Tests
```bash
bundle exec rake              # Run all specs + cucumber features (default task)
bundle exec rake spec         # RSpec only
bundle exec rake cucumber     # Cucumber features only
bundle exec rspec spec/models/tang/plan_spec.rb          # Single spec file
bundle exec rspec spec/models/tang/plan_spec.rb:15       # Single example by line
```

### Linting & Security
```bash
bundle exec rubocop           # Ruby linting
bundle exec brakeman -q -z    # Security analysis
bundle exec rake rails_best_practices  # Code quality
bundle exec rake check        # All checks: spec + cucumber + brakeman + rails_best_practices
```

### Development
```bash
bundle exec rake rails:console    # Rails console via dummy app
bundle exec rake assets:precompile  # Precompile assets in dummy app
```

### Publishing
```bash
gem build tang.gemspec
gem push tang-x.x.x.gem
npm publish
```

## Architecture

### Rails Engine Structure

Tang is an isolated namespaced engine (`Tang::Engine` with `isolate_namespace Tang`). All models, controllers, and views live under the `Tang` namespace. The engine mounts `StripeEvent::Engine` at `/stripe_event` for webhook handling.

### Configuration

The host app configures Tang via an initializer using `Tang.setup`:
- `customer_class` — the app's user model (default: `'User'`). The host model must `include Tang::Customer`.
- `default_currency`, `free_plan_name`, `admin_email`, `company_name`
- `plan_inheritance` — when true, higher-order plans inherit access to lower-order features
- `delayed_email` — controls `deliver_later` vs `deliver_now` for mailers
- `admin_layout`, `pricing_layout` — layout templates for admin/pricing views

Environment variables: `STRIPE_SECRET_KEY`, `STRIPE_SIGNING_SECRET`.

### Key Models and Relationships

- **Customer** (`Tang::Customer` concern) — mixed into the host app's User model. Provides `has_many :subscriptions, :cards, :invoices, :charges`. Has `subscribed_to?(stripe_id)` for plan access checking with optional inheritance.
- **Subscription** — belongs to customer and plan. Uses AASM state machine with states: `trialing → active → past_due → canceled/unpaid`. Has `before_update` hook to sync with Stripe. Sends upgrade email on plan change.
- **Plan** — has `order` field for plan hierarchy. Intervals: day/week/month/year. Syncs CRUD operations with Stripe via lifecycle callbacks.
- **Coupon** — durations: once/repeating/forever. Can be applied to customers or subscriptions. Synced with Stripe.
- **Invoice** / **InvoiceItem** / **Charge** / **Card** — mirror Stripe objects locally.

### Service Objects (app/services/tang/)

All Stripe API interactions go through service objects using a `self.call` pattern (e.g., `CreateSubscription.call(plan, customer, token)`). Services handle: creating/updating/canceling subscriptions, managing cards, applying/removing discounts, invoice operations, and plan/coupon CRUD.

### Webhook Processing (config/initializers/stripe_event.rb)

Uses `stripe_event` gem. Handles: `invoice.created`, `invoice.payment_succeeded`, `invoice.payment_failed`, `customer.subscription.deleted`, `charge.dispute.created`. Deduplicates via `StripeWebhook` model.

### Controllers

Two namespaced sets:
- `Tang::Account::*` — customer-facing (subscription, card, coupon, receipts)
- `Tang::Admin::*` — admin dashboard (customers, plans, coupons, subscriptions, invoices, payments, search)

### Background Jobs (app/jobs/tang/)

Import jobs for syncing Stripe data: `ImportStripeJob` orchestrates `ImportPlansJob`, `ImportCouponsJob`, `ImportCustomersJob`, `ImportSubscriptionsJob`, `ImportInvoicesJob`, `ImportChargesJob`. Run via `rake tang:import_stripe`.

### Test Setup

- RSpec specs use `stripe-ruby-mock` gem to stub Stripe API calls
- Factories defined in `spec/factories.rb` using FactoryBot
- Dummy app at `spec/tang_app/` with PostgreSQL (`pg`)
- Cucumber features cover subscription lifecycle scenarios (subscribe, upgrade, cancel, discounts, trials, receipts)

### Key Dependencies

- `stripe` + `stripe_event` — Stripe API and webhooks
- `aasm` — state machine for subscription status
- `paper_trail` — audit trail on Plan, Subscription, Coupon
- `devise` — authentication (in dummy app / expected in host)
- `will_paginate` — pagination
