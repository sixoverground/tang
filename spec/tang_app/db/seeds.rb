admin = User.create(
  email: 'admin@tangapp.herokuapp.com',
  password: 'password',
  role: 'admin'
)

customer = User.create(
  email: 'customer@tangapp.herokuapp.com',
  password: 'password'
)

gold = Tang::Plan.create(
  stripe_id: 'gold',
  name: 'Gold',
  amount: 2000,
  interval: 'month',
  highlight: true,
  order: 1
)

diamond = Tang::Plan.create(
  stripe_id: 'diamond',
  name: 'Diamond',
  amount: 5000,
  interval: 'month',
  order: 2
)

coupon = Tang::Coupon.create(
  stripe_id: 'half-off',
  duration: 'once',
  percent_off: 50
)