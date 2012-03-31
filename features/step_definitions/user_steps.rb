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

Given /^I am logged in$/ do
  step 'I am logged in as "test@testing.com"'
end

Given /^I am logged in as "([^"]+)"$/ do |email|
  user = User.create! :email => email, :password => "password"
  user.update_attribute("admin",false)
  user.confirm!
  step "I am on the homepage"
  step 'I follow "Sign in"'
  step 'I fill in "Email" with "'+email+'"'
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
When /^recommendations for user "([^"]+)" are as follows:$/ do |user_email,table|
  coll = $db["recommendations"]
  movie_coll = $db["movies"]
  user = User.all(conditions:{email: user_email},limit: 1).to_a[0]
  table.hashes.each do |attributes|
    movie_id = movie_coll.find({"title"=>attributes["movie"]}).to_a[0]["_id"]
    coll.insert({"user"=>user.id.to_s,"movie"=>movie_id.to_s,"estimated_rating"=>attributes["rating"]})
 end
end