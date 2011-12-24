Given /^(?:|I )am on (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^user can see (["]{1}([a-zA-Z ]+)["]{1}) text in the page$/ do |text_quoted,text|
  page.has_content?(text).should be_true
end

When /^user clicks link ([a-z_]+)$/ do |link|
  click_link(link)
end

When /^user clicks link (["]{1}([a-zA-Z ]+)["]{1})$/ do |all,link|
  click_link(link)
end

When /^user fill in ([a-z_]+) with ([a-z_@\.]+)$/ do |id,value|
  fill_in(id, :with => value)
end

When /^user press ([a-z_]+)$/ do |id|
  click_button(id)
end

When /^user press (["]{1}([a-zA-Z ]+)["]{1})$/ do |all,value|
  click_button(value)
end

Then /^the button ([a-z_]+) exists$/ do |id|
  find_button(id)
end