Given /^there are the following users:$/ do |table|
  table.hashes.each do |attributes|
    @user = User.create!(attributes)
    @user.update_attribute("admin", attributes["admin"] == "true")
  end
end

Given /^there are the following confirmed users:$/ do |table|
  table.hashes.each do |attributes|
    @user = User.create!(attributes)
    @user.update_attribute("admin", attributes["admin"] == "true")
    @user.confirm!
  end
end

Given /I am logged in/ do
  user = User.create! :email => "test@testing.com", :password => "password"
  user.update_attribute("admin",false)
  user.confirm!
  step "I am on the homepage"
  step 'I follow "Sign in"'
  step 'I fill in "Email" with "test@testing.com"'
  step 'I fill in "Password" with "password"'
  step 'I press "Sign in"'
end

Given /^I am signed in as them$/ do
  steps(%Q{
Given I am on the homepage
When I follow "Sign in"
And I fill in "Email" with "#{@user.email}"
And I fill in "Password" with "password"
And I press "Sign in"
Then I should see "Signed in successfully."
})
end