$ ->
  $form = $('#payment-form')
  $form.submit( (event) ->

    name = $('input[data-stripe="name"]').val()
    if name.trim().length == 0
      alert('Please enter a valid cardholder name.')
      return false

    number = $('input[data-stripe="number"]').val()
    valid = $.payment.validateCardNumber(number)
    if !valid
      alert('Please enter a valid credit card number.')
      return false

    exp = $('input[data-stripe="exp"]').payment('cardExpiryVal')
    valid = $.payment.validateCardExpiry(exp.month, exp.year)
    if !valid
      alert('Please enter a valid expiration date.')
      return false

    cvc =  $('input[data-stripe="cvc"]').val()
    cardType = $.payment.cardType(number)
    valid = $.payment.validateCardCVC(cvc, cardType)
    if !valid
      alert('Please enter a valid CVC code.')
      return false

    zip = $('input[data-stripe="address_zip"]').val()
    if zip.trim().length < 5
      alert('Please enter a valid zip code.')
      return false

    $form.find('.submit').prop('disabled', true)
    Stripe.card.createToken($form, stripeResponseHandler)
    return false
  )

  $('input[data-stripe="number"]').payment('formatCardNumber')
  $('input[data-stripe="exp"]').payment('formatCardExpiry')
  $('input[data-stripe="cvc"]').payment('formatCardCVC')
  $('input[data-stripe="address_zip"]').payment('restrictNumeric')

stripeResponseHandler = (status, response) ->
  $form = $('#payment-form')
  if response.error
    $form.find('.payment-errors').text(response.error.message)
    $form.find('.submit').prop('disabled', false)
  else
    if window.testStripeToken?
      token = window.testStripeToken
    else
      token = response.id
    
    $form.append($('<input type="hidden" name="stripe_token">').val(token))
    $form.get(0).submit()