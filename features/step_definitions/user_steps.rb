Given /^there are the following users:$/ do |table|
  table.hashes.each do |attributes|
    @user = User.create!(attributes)
  end
end

Given /^there are the following confirmed users:$/ do |table|
  table.hashes.each do |attributes|
    @user = User.create!(attributes)
    @user.confirm!
  end
end

Given /I am logged in/ do
  user = User.create! :email => "test@testing.com", :password => "password"
  user.confirm!
  step "I am on the homepage"
  step 'I follow "Sign in"'
  step 'I fill in "Email" with "test@testing.com"'
  step 'I fill in "Password" with "password"'
  step 'I press "Sign in"'
end