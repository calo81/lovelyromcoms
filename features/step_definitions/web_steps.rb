Given /^(?:|I )am on (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^user can see (["]{1}([0-9a-zA-Z ]+)["]{1}) text in the page$/ do |text_quoted,text|
  page.has_content?(text).should be_true
end

When /^I should see "([^"]+)"$/ do |text|
  page.has_content?(text).should be_true
end

When /^I should not see "([^"]+)"$/ do |text|
  page.has_content?(text).should be_false
end

When /^I should see elements with class "([^"]+)" ([0-9]+) times$/ do |text,times|
  results = all(".#{text}")
  results.size.should == times.to_i
end


When /^I should see css "([a-z ]+)" with content "([A-Za-z 0-9]+)"$/ do |css,title|
  clean_text = find(css).text.gsub("\n","")
  clean_text.strip.should == title
end

When /^user clicks link ([a-z_]+)$/ do |link|
  click_link(link)
end

When /^user clicks link (["]{1}([a-zA-Z ]+)["]{1})$/ do |all,link|
  click_link(link)
end

When /^I follow "([a-zA-Z 0-9]+)"$/ do |link|
  click_link(link)
end

When /^I follow ([a-z_]+)$/ do |link|
  click_link(link)
end

When /^user fill in ([a-z_]+) with ([a-z_@\.]+)$/ do |id,value|
  fill_in(id, :with => value)
end

When /^I fill in "([a-zA-Z_0-9]+)" with "([a-zA-Z @\.\:\/]+)"$/ do |id,value|
  fill_in(id, :with => value)
end

When /^user press ([a-z_]+)$/ do |id|
  click_button(id)
end

When /^I press (["]{1}([a-zA-Z ]+)["]{1})$/ do |full_path,id|
  click_button(id)
end

When /^user press (["]{1}([a-zA-Z ]+)["]{1})$/ do |all,value|
  click_button(value)
end

Then /^the button ([a-z_]+) exists$/ do |id|
  find_button(id)
end

Then /^show me the page$/ do
  save_and_open_page
end
