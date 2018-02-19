def create_customer_attributes
  @customer_attributes ||= FactoryBot.attributes_for(:customer, password_confirmation: 'password')
end

def create_admin_attributes
  @admin_attributes ||= FactoryBot.attributes_for(:admin, password_confirmation: 'password')
end

# def find_customer
#   @customer ||= Tang.customer_class.constantize.where(email: @customer_attributes[:email]).first
# end

# def find_admin
#   @admin ||= Tang.customer_class.constantize.where(email: @admin_attributes[:email]).first
# end

# def create_uncomfirmed_customer
#   create_customer_attributes
#   delete_customer
#   sign_up
#   visit '/users/sign_out'
# end

# def create_uncomfirmed_admin
#   create_admin_attributes
#   delete_admin
#   sign_up
#   visit '/users/sign_out'
# end

def create_customer
  create_customer_attributes
  delete_customer
  @customer ||= FactoryBot.create(:customer, @customer_attributes)
end

def create_admin
  create_admin_attributes
  delete_admin
  @admin ||= FactoryBot.create(:admin, @admin_attributes)
end

def delete_customer
  @customer ||= Tang.customer_class.where(email: @customer_attributes[:email]).first
  @customer.destroy unless @customer.nil?
end

def delete_admin
  @admin ||= Tang.customer_class.where(email: @admin_attributes[:email]).first
  @admin.destroy unless @admin.nil?
end

# def sign_up_customer
#   delete_customer
#   visit '/users/sign_up'
#   fill_in "user_email", with: @customer_attributes[:email]
#   fill_in "user_password", with: @customer_attributes[:password]
#   fill_in "user_password_confirmation", with: @customer_attributes[:password_confirmation]
#   click_button "Sign up"
#   find_customer
# end

# def sign_up_admin
#   delete_admin
#   visit '/users/sign_up'
#   fill_in "user_email", with: @admin_attributes[:email]
#   fill_in "user_password", with: @admin_attributes[:password]
#   fill_in "user_password_confirmation", with: @admin_attributes[:password_confirmation]
#   click_button "Sign up"
#   find_admin
# end

def sign_out
  visit '/users/sign_out'
end

def sign_in_customer
  visit '/users/sign_in'
  fill_in 'user_email', with: @customer_attributes[:email]
  fill_in 'user_password', with: @customer_attributes[:password]
  click_button 'Log in'
end

def sign_in_admin
  visit '/users/sign_in'
  fill_in 'user_email', with: @admin_attributes[:email]
  fill_in 'user_password', with: @admin_attributes[:password]
  click_button 'Log in'
end

Given /^I am not logged in$/ do
  sign_out
end

Given /^I am logged in as a customer$/ do
  sign_out
  create_customer
  sign_in_customer
end

Given /^I am logged in as an admin$/ do
  sign_out
  create_admin
  sign_in_admin
end