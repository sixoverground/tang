User.create(
  email: 'admin@tangapp.herokuapp.com',
  password: 'password',
  role: 'admin'
)

User.create(
  email: 'customer@tangapp.herokuapp.com',
  password: 'password'
)

Tang::Plan.create(
  stripe_id: 'gold',
  name: 'Gold',
  amount: 2000,
  interval: 'month',
  highlight: true,
  order: 1
)

Tang::Plan.create(
  stripe_id: 'diamond',
  name: 'Diamond',
  amount: 5000,
  interval: 'month',
  order: 2
)

Tang::Coupon.create(
  stripe_id: 'half-off',
  duration: 'once',
  percent_off: 50
)
